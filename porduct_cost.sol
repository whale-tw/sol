pragma solidity ^0.4.0;
contract Product_Cost {
   address public store; //�ӫ~��m
   uint    public price; //�ӫ~����
   uint    public amountRaised; //�ө��֭p���B

   /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    
    event BuyThing(address buyer,  bool isContribution);
    event FundTransfer(address backer, uint amount, bool isContribution); 
    
    function Product_Cost ( address _store, uint8 _price) { 
        store = _store;
        price = _price * 1 ether;
    }
    
    function payalbe () {
        uint buypay_value = msg.value;
        uint change;
        if (buypay_value < price) throw; //�ʶR��X���p��ӫ~����,���z�L
        if (buypay_value >= price) { //�j��ӫ~����,
            change = buypay_value - price; //��s
            msg.sender.send(change); //��s
        }

        balanceOf[msg.sender] += price; //�Ӯa�b��ֶi���B
        amountRaised += price;

        BuyThing(msg.sender, true); //�R�a�R��ӫ~
    }
    
    function Withdrawal() { 
      if(msg.sender != store) throw;  //���a���
      store.send(amountRaised);
      FundTransfer(store, amountRaised, true);  
    }

}