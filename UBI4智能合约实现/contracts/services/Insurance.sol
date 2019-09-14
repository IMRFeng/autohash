pragma solidity >=0.4.21 <0.6.0;

import "../Claim.sol";
import "../helpers/Managed.sol";
import "../persistance/InsurancePersistance.sol";


contract Insurance {
    

    //保险公司
    address public insurer;

    
    struct userInsurance{
        uint state;
        uint premium;
        uint protection;
        uint duration;
        
        
    }
    
    struct carInfo{
        uint VIN;
        uint upload_time;
        uint longitude;
        uint latitude;
        uint milesum;
        uint gas;
        uint speed;
        uint rotat_speed;
    }
    
    struct User{
        //投保的状态
        address userAddress;
        
        string username;
        //address oracle;
        //uint premium;
        //uint prot;
        //uint duration;
        //uint state;
        uint numInsurances;
        mapping(uint=>userInsurance) insurances;
    }
    
    uint public numUsers;
    uint public numInsurances;
    mapping(uint=>User) public  users;
    mapping (address => uint) public balances;
    mapping (address=>carInfo)  public carInfos;
    
    //给一个用户的地址，新增一个用户
    function newUser(address userAddress,string username) returns (uint userID) {
        userID = numUsers++; 
        users[userID]=User(userAddress,username,0);
        newUsered(msg.sender,numUsers);
    }

    //购买保险
    function newInsurance(uint userID,uint premium,uint prot,uint duration)payable{
        User u=users[userID];
        u.insurances[u.numInsurances++]=userInsurance(0,premium,prot,duration);
        NewInsuranced(msg.sender,u.numInsurances);
    }
    
    
    //得到投保人的姓名和投保的状态
    function getUser(uint userID,uint numInsurances)constant returns(address,string,uint)
    {
        User u=users[userID];
        return (u.userAddress,
        u.username,
        u.numInsurances
        //u.insurances[numInsurances].state,
        //u.insurances[numInsurances].premium,
        //u.insurances[numInsurances].protection,
        //u.insurances[numInsurances].duration
        );
    }


    function getInsurance(uint userID,uint numInsurances)constant returns(uint,uint,uint,uint)
    {
        User u=users[userID];
        return(
        u.insurances[numInsurances].state,
        u.insurances[numInsurances].premium,
        u.insurances[numInsurances].protection,
        u.insurances[numInsurances].duration
            );
    }
    
    function getNumUsers() constant returns (uint) {
        return numUsers;
    }
    function getNumInsurances()constant returns(uint){
        return  numInsurances;
    }
  
   //转Token
  function sendMoney(address receiver, uint amount) payable{
        if (balances[msg.sender] < amount) return;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        SentMoney(msg.sender, receiver, amount);
    }


    

}



