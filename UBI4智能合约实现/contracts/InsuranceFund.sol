pragma solidity >=0.4.21 <0.6.0;

import "./Provident.sol";

import "services/InsuranceService.sol";

import "persistance/AccountingPersistance.sol";

import "helpers/Managed.sol";

contract InsuranceFund is Manager { 
  bool isBootstraped;
  event TokenAddressChanged(address newTokenAddress);

  function InsuranceFund() {
    owner = msg.sender;
    isBootstraped = false;
    bootstrapPersistance();
  }

  function getNumberOfInsurancePlans() view public returns (uint16) {
    return insurance().getPlanCount();
  }

  function getInsurancePlanPrice(uint16 plan) view public returns (uint256) {
    return insurance().getPlanPrice(plan);
  }

  function getInsuredProfile() view public returns (int16 plan, uint256 startDate, uint256 finalDate) {
    var (p,s,f,) = insurance().getInsuranceProfile(msg.sender);
    return (p,s,f);
  }

  function buyInsurancePlan(uint16 plan) payable public {
    if (!insurance().buyInsurancePlanFor(msg.sender, msg.value, plan)) {
      throw; 
    }
    accounting().saveTransaction(AccountingPersistance.TransactionDirection.Incoming, msg.value, msg.sender, this, 'premium bought', false);
  }

  function createClaim(uint16 claimType, string evidence, address beneficiary) public returns (bool) {
    return insurance().createClaim(msg.sender, claimType, evidence, beneficiary);
  }

  function getTokenAddress() view public returns (address) {
    return address(investment());
  }

  function getCurrentTokenOffer() view public returns (uint256 price, uint256 availableTokens) {
    return (investment().tokenPrice(), investment().availableTokenSupply());
  }

  function buyTokens() payable public {
    if (!investment().buyTokens(msg.sender, msg.value)) {
      throw;
    }
    accounting().saveTransaction(AccountingPersistance.TransactionDirection.Incoming, msg.value, msg.sender, this, 'tokens bought', false);
  }

  function withdrawDividends() public {
    investment().withdrawDividendsForHolder(msg.sender);
  }

 

  modifier onlyWaivedServices {
    if (msg.sender == addressFor('InsuranceService') || msg.sender == addressFor('InvestmentService')) {
      _;
    } else {
      throw;
    }
  }

  function sendFunds(address recipient, uint256 amount, string concept, bool isDividend) onlyWaivedServices returns (bool) {
    accounting().saveTransaction(AccountingPersistance.TransactionDirection.Outgoing, amount, this, recipient, concept, isDividend);
    if (!recipient.send(amount)) {
      throw;
    }
    return true;
  }

  function insurance() private returns (InsuranceService) {
    return InsuranceService(addressFor('InsuranceService'));
  }



  function accounting() private returns (AccountingPersistance) {
    return AccountingPersistance(addressFor('AccountingDB'));
  }


  function bootstrapPersistance() onlyOwner {
    if (isBootstraped) {
      throw;
    }
    InsurancePersistance insuranceDB = new InsurancePersistance();
    addPersistance(address(insuranceDB));
    AccountingPersistance accountingDB = new AccountingPersistance();
    addPersistance(address(accountingDB));
    InvestmentPersistance investmentDB = new InvestmentPersistance();
    addPersistance(address(investmentDB));
    isBootstraped = true;
  }

  function setInsuranceService(address insurance, bool setInitialPlans) onlyOwner {
    InsuranceService insuranceService = InsuranceService(insurance);
    addService(insurance);
    assignInsuranceServicePermissions(insurance);

    if (setInitialPlans) {
      insuranceService.setInitialPlans();
    }
  }



  function assignAllPermissions() onlyOwner {
    assignInsuranceServicePermissions(address(insurance()));
    assignInvestmentServicePermisions(address(investment()));

  }

  function assignInsuranceServicePermissions(address insurance) onlyOwner {
    InsurancePersistance(addressFor('InsuranceDB')).assignPermission(insurance, Managed.PermissionLevel.Write);
  }

}
