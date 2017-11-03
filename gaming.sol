
assh pi@192.168.8.6 solidity ^0.4.13;

contract ERC20Token {
  function transferFrom(address from, address to, uint value);
  function transfer(address _to, uint256 _value);
}

contract Gaming {
    uint public totalfunder;
    uint public result;
    uint public prediction_value;
    bool public outputresult_enable = false;
    string public finialresult;
    
    event Fund1Transfer(address backer, uint amount, bool isContribution);
    event Fund2Transfer(address backer, uint amount, bool isContribution);
    
    /* data structure to hold information about campaign contributors */
    struct Funder1{
        address addr;
        uint    amount;
    }
    
    struct Funder2{
        address addr;
        uint    amount;
    }
    
    uint funderID1;
    mapping (uint => Funder1) public funders1;
    
    uint funderID2;
    mapping (uint => Funder2) public funders2;
    
    //Funder[] public funders;
    
  function Gaming(uint _prediction_value) {
      
      prediction_value = _prediction_value;
  }  
  
  function outputresult (bool _enable, uint _resultvalue) {
        outputresult_enable = _enable;
        result = _resultvalue;
    }
    
      modifier outputresultAllowed {
        assert(outputresult_enable);
        _;
      }
    

  function bet1(address tokenAddr, uint _betting1) {
  //function bet1(address tokenAddr) {
    ERC20Token tok = ERC20Token(tokenAddr);
    tok.transferFrom(msg.sender, this, _betting1);
    totalfunder += _betting1;
    funders1[funderID1++] = Funder1(msg.sender, _betting1);
    Fund1Transfer(msg.sender, _betting1 ,true);
  }
  
  
  function bet2(address tokenAddr, uint _betting1) {
  //function bet1(address tokenAddr) {
    ERC20Token tok = ERC20Token(tokenAddr);
    tok.transferFrom(msg.sender, this, _betting1);
    totalfunder += _betting1;
    funders2[funderID2++] = Funder2(msg.sender, _betting1);
    Fund2Transfer(msg.sender, _betting1 ,true);
  }
  
  function sendresult (address tokenAddr ) outputresultAllowed {
        uint i;
        ERC20Token tok = ERC20Token(tokenAddr);
        
        if(result  > prediction_value) {
            uint avg_amount1 =  totalfunder / funderID1;
            for ( i = 0; i < funderID1; ++i) {
              tok.transfer(funders1[i].addr, avg_amount1);
            } 
            finialresult = "bet1 win";
            
        }
        else {
            uint avg_amount2 =  totalfunder / funderID2;
            for ( i = 0; i < funderID2; ++i) {
              tok.transfer(funders2[i].addr, avg_amount2);
            } 
            finialresult = "bet2 win";
        }
    } 
  
  
}


