pragma solidity >=0.4.25 <0.9.0;
 
import "../contracts/Token.sol";
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract TestToken {

	string public name = "StanToken";
	string public symbol = "STT";

	Token token = Token(DeployedAddresses.Token());
    uint expectedTotalSupply = 1000000;

    //event Transfer(uint amount, address from, address to);

	function testTokenInitialSupply() public {
    	Assert.equal(token.maxTotalSupply(), expectedTotalSupply, "Initial supply is correct");
	}

	address adminAddress = token.admin();
	uint balanceOfAdmin = token.balances(adminAddress);

	function testBalanceOfAdmin() public {
		Assert.equal(balanceOfAdmin, expectedTotalSupply, "Balance of admin IS NOT equal total supply");
	}

	function testNameAndSymbol() public {
		Assert.equal(token.name(), "Stans Token", "Wrong token name");
		Assert.equal(token.symbol(), "STT", "Wrong token symbol");
	}

	function testTranfer() public {
		uint amount = 2;

		address to = address(0xD8Ce37FA3A1A61623705dac5dCb708Bb5eb9a125);
		Assert.isTrue(token.transfer
			(to, amount), 
			"Transfer failed"); 

		Assert.equal(token.balanceOf(to), 
			amount, "Amount of recipient not equal to amount");

		uint maxtotalSupply = token.maxTotalSupply();

		Assert.equal(token.balanceOf(address(adminAddress)),
			(maxtotalSupply - amount), "Amount of sender not equal is not -2");

		eventFrom = token.events.Transfer({
			fromBlock : "latest"
		});

		let value = eventFrom.returnValues;
		console.log("Event from ", eventFrom);
		

			
	}

}


