pragma solidity >=0.4.21 <0.6.0;

contract Provident {

  // 投保人相关
  function getNumberOfInsurancePlans() view public returns (uint16);
  function getInsurancePlanPrice(uint16 plan) view public returns (uint256);
  function getInsuredProfile(address insured) view public returns (int16 plan, uint256 startDate, uint256 finalDate);

  function buyInsurancePlan(uint16 plan) payable public;
  function createClaim(uint16 claimType, string evidence, address beneficiary) public returns (bool);

  event TokenAddressChanged(address newTokenAddress);
  function getTokenAddress() view public returns (address); // ERC20 Compliant Token
  function getCurrentTokenOffer() view public returns (uint256 price, uint256 availableTokens);

  function buyTokens() payable public;
  function withdrawDividends() public;
}
