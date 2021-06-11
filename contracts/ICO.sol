pragma solidity >=0.4.22 <0.9.0;

contract ICO {

	mapping(address => uint) public balances;
	uint public totalSupply;
	uint public tokensLeft;
	address public admin;

	constructor(uint _totalSupply) public {
		totalSupply = _totalSupply;
		tokensLeft = _totalSupply;
		admin = msg.sender;
	}

	function buyToken(uint quantity) external payable {
		require(msg.value >= quantity/10, 
			"Value in ether must be enough to buy tokens");
		require(tokensLeft >= quantity, "Not enough tokens left");
		balances[msg.sender] = balances[msg.sender] + quantity;
		tokensLeft  = tokensLeft - quantity;
	}

	function updateTokensLeft(uint amount) external {
		require(msg.sender == admin, "Only admin address");
		tokensLeft = amount;
	} 

	function balanceOf(address holder) external view returns(uint) {
		return balances[holder];
	}











}