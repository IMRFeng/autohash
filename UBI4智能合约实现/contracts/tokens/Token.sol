pragma solidity >=0.4.21 <0.6.0;

contract Token {

  uint256 public totalSupply;

  //返回余额
  function balanceOf(address _owner) view returns (uint256 balance);

  function transfer(address _to, uint256 _value) returns (bool success);


  //转账成功与否
  function transferFrom(address _from, address _to, uint256 _value) returns (bool success);

  //审核是否通过
  function approve(address _spender, uint256 _value) returns (bool success);

  function allowance(address _owner, address _spender) view returns (uint256 remaining);

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
