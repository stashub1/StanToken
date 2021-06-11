pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";



//Creating our own contract
contract Token {

	address public admin;
	uint public maxTotalSupply;
	mapping(address => uint) public balances;

	event Transfer(address indexed from, address indexed to, uint256 amount);

	constructor(string memory name, 
				string memory symbol,
				uint _initialSupply) 
				 public {

		admin = msg.sender;
		maxTotalSupply = _initialSupply;
		balances[msg.sender] = maxTotalSupply; 
	}

    function transfer(address recipient, uint amount) 
     public returns(bool) {
     	require(balanceOf(admin) >= amount);
		balances[admin] = balances[admin] - amount;
		balances[recipient] = balances[recipient] + amount;  
		emit Transfer(admin, recipient, amount);

		return true;
	}

	//transfer event
	//transfer function


	function balanceOf(address _owner) public view returns(uint256) {
		return balances[_owner];
	}


	function updateAdmin(address newAdmin) external {
		require(msg.sender == admin, "Only admin can update admin");
		admin = newAdmin;
	}



	


}