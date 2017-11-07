pragma solidity ^0.4.18;
import "./EtherealFoundationOwned.sol";
import "./EtherealToken.sol";

contract EtherealTipJar  is EtherealFoundationOwned{
    string public constant CONTRACT_NAME = "EtherealTipJar";
    string public constant CONTRACT_VERSION = "B";
    string public constant QUOTE = "'The universe never did make sense; I suspect it was built on government contract.' -Robert A. Heinlein";
    
    
    event RecievedTip(address indexed from, uint256 value);
	function () payable public {
		RecievedTip(msg.sender, msg.value);		
	}
	
	event TransferedEth(address indexed to, uint256 value);
	function TransferEth(address to, uint256 value) public onlyOwner{
	    require(this.balance >= value);
	    
        if(value > 0)
		{
			to.transfer(value);
			TransferedEth(to, value);
		}   
	}
    
    event TransferedERC20(address tokenContract, address indexed to, uint256 value);
	function TransferERC20(address tokenContract, address to, uint256 value) public onlyOwner{
	    
	    EtherealToken token = EtherealToken(tokenContract);
	    
        if(value > 0)
		{
			token.transfer(to, value);
			TransferedERC20(tokenContract,to, value);
		}   
	}
}
