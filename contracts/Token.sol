pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

gd2pdoi[2ou3-9t7=-\`
a
z;qx;n1223446789=\]q[wl'		lw[j	pa[>?zvkjegoiw0170836950-4]]]

//Creating our own contract
contract Token {

	address public admin;
	uint public totalSupply;
	string public name;
	string public symbol;
	mapping(address => uint) public balances;
	mapping(address => mapping(address => uint)) public allowances;

	event Approval(address owner, address spender, uint value);
	event Transfer(address indexed from, address indexed to, uint256 amount);

	constructor(string memory _name, 
				string memory _symbol,
				uint _initialSupply) 
				 public {

		name = _name;
		symbol = _symbol;
		admin = msg.sender;
		totalSupply = _initialSupply;
		balances[msg.sender] totalSupply; 
	}

    function transfer(address recipient, uint amount) 
     public returns(bool) {
     	require(balanceOf(msg.sender) >= amount);
		balances[msg.sender] = balances[msg.sender] - amount;
		balances[recipient] = balances[recipient] + amount;  
		emit Transfer(admin, recipient, amount);
		return true;
	}


	function approve(address _spender, uint _amount) external returns(bool) {
		emit Approval(msg.sender, _spender, _amount);
		allowances[msg.sender][_spender] = _amount;
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

	function allowance(address _owner, address _spender) public view returns(uint) {
		return allowances[_owner][_spender];
	}

	function mint(address recipient, uint amount) external returns(bool) {
		require(msg.sender == admin, "Only admin can mint tokens");
		balances[msg.sender] = amount;
		totalSupply = totalSupply + amount;
	}

	function transferFrom(address sender, address recipient, uint amount) external returns(bool) {
		require(allowance(sender,recipient) >= amount);
		require(balanceOf(sender) >= amount);
		balances[sender]= balances[sender] - amount;
		balances[recipient] = balances[recipient] + amount;
		allowances[sender][msg.sender] = allowances[sender][msg.sender]- amount;
		emit Transfer(sender, recipient, amount);
		//require(allowance is enough)
		//require (Sender has enough money)

		return true;
	} 


	


}