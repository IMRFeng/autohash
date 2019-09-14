pragma solidity >=0.4.21 <0.6.0;

import "../Claim.sol";
import "../helpers/Managed.sol";
import "../persistance/InsurancePersistance.sol";

contract InsuranceService is Managed('InsuranceService') {
    uint  private insurancePeriod = 30 days;

    event InsuranceBought(address insured, uint16 insuranceType);
    event NewClaim(address claimAddress, address originator);
    event PayoutForClaim(address claimAddress, uint256 claimAmount);

    function InsuranceService() {
    }

    function setInsurancePlans(uint256[] plans) requiresPermission(PermissionLevel.Write) {
      persistance().setInsurancePlans(plans);
    }

    function getPlanCount() requiresPermission(PermissionLevel.Read) view returns (uint16) {
      return persistance().planTypes();
    }

    function getPlanPrice(uint16 plan) requiresPermission(PermissionLevel.Read) view returns (uint256) {
      return persistance().planPrices(plan);
    }

    function setInitialPlans() {
      setInsurancePlans(getInitialInsurancePrices(3));
    }

    function getInitialInsurancePrices(uint16 k) view private returns (uint256[]) {
      uint256[] memory prices = new uint256[](k);
      for (uint16 i=0; i < k; i++) {
        prices[i] = uint256(i + 1) * 20 finney;
      }
      return prices;
    }

    function getInsuranceProfile(address insured) view returns
     (int16 plan,
      uint256 startDate,
      uint256 finalDate,
      uint256 totalSubscribedClaims) {
      var (p, s, f, cs) = persistance().insuredProfile(insured);
      return (s > 0 ? int16(p) : int16(-1), s, f, cs);
    }

    function getInsurancePlan(address insured) view returns (int256 plan) {
      (plan,) = getInsuranceProfile(insured);
      return;
    }

    function getPlanIdentifier(uint16 planType) view returns (uint16) {
      return 1 + 100 * planType;
    }

    function isInsured(uint256 startDate, uint256 finalDate) private view returns (bool) {
      return finalDate >= now && startDate <= now;
    }

    function buyInsurancePlanFor(address insured, uint256 amountPayed, uint16 planType) payable returns (bool) {
      if (int256(amountPayed) < int256(persistance().planPrices(planType))) {
         return false;
      }
      uint16 planIdentifier = getPlanIdentifier(planType);
      var (p, s, f, cc) = getInsuranceProfile(insured);

      uint256 planStart = isInsured(s, f) ? s : now;
      persistance().setInsuranceProfile(insured, int16(planIdentifier), int256(planStart), int256(planStart + insurancePeriod));

      InsuranceBought(msg.sender, planIdentifier);

      return true;
    }

    function createClaim(address claimer, uint16 claimType, string evidence, address beneficiary) returns (bool) {
      Claim newClaim = new Claim(claimType, evidence, manager, beneficiary);
      newClaim.transferOwnership(claimer);
      return submitClaim(newClaim, claimType);
    }

    function submitClaim(Claim submittedClaim, uint16 claimType) returns (bool) {
      uint16 planId = getPlanIdentifier(claimType);

      var claimer = submittedClaim.ownerAddress();

      var (plan, startDate, finalDate, subscribedClaims) = getInsuranceProfile(claimer);
      if (plan <= 0 || uint16(plan) != planId || !isInsured(startDate, finalDate)) {
        return false;
      }

      var claimAddress = address(submittedClaim);

      persistance().addClaim(claimAddress);
      persistance().subscribeInsuredToClaim(claimer, claimAddress);

      NewClaim(claimAddress, claimer);

      var examiners = examinersForClaim(claimType);
      var neededAprovals = uint16(examiners.length);

      submittedClaim.transitionState(Claim.ClaimStates.Review);
      submittedClaim.assignExaminers(examiners, neededAprovals);

      return true;
    }

    function transferForClaim(address claimAddress) {
      Claim claim = Claim(claimAddress);
      if (claim.currentState() == Claim.ClaimStates.Accepted) {
        uint256 claimAmount = moneyForClaim(claim.claimType());
        if (Manager(manager).sendFunds(claimAddress, claimAmount, 'claim', false) &&
            claim.currentState() == Claim.ClaimStates.Payed) {
          PayoutForClaim(claimAddress, claimAmount);
        } else {
          throw;
        }
      }
    }

    function examinersForClaim(uint16 claimType) private returns (address[]) {
      var examinerCount = persistance().examinerIndex();
      address[] memory claimExaminers = new address[](examinerCount);
      for (uint16 i = 0; i < examinerCount; i++) {
        claimExaminers[i] = persistance().examiners(i);
      }
      return claimExaminers;
    }

    function moneyForClaim(uint16 claimType) view returns (uint256) {
      return 5 ether;
    }

    function persistance() view private returns (InsurancePersistance) {
      return InsurancePersistance(addressFor('InsuranceDB'));
    }

    function () payable {}
}
