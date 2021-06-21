const Token = artifacts.require("Token");


contract('Token' , function(accounts) {

	var tokenInstance;
	var fromAccount;
	var toAccount;
	var callingAccount;


	it('approves token for delegaed transfer', function() {
		return Token.deployed()
		.then(function(instance) {
			tokenInstance  = instance;
			return tokenInstance.approve.call(accounts[1],100);
		})
		.then(function(success) {
			assert.equal(success, true, "it returns false");
			return tokenInstance.approve(accounts[4], 400);
		}).then(function(recipt) {
			assert.equal(recipt.logs.length, 1, "triggers more than 1 event");
			assert.equal(recipt.logs[0].event, "Approval", "Event is not Approval");
			assert.equal(recipt.logs[0].args.owner, accounts[2], "Owner is wrong");
			assert.equal(recipt.logs[0].args.spender, accounts[4], "Spender is wrong");
			assert.equal(recipt.logs[0].args.value, 400, "Value is not equal to 400");
			return tokenInstance.allowance(accounts[2], accounts[4]);
		}).then(function(allowance) {
			assert.equal(allowance, 400, "Allowense amount is not corresct");
		});

	});

	it('handles delegated transfer', function() {
		return Token.deployed()
		.then(function(instance) {
			tokenInstance = instance;
			fromAccount = accounts[7];
			toAccount = accounts[5];
			callingAccount = accounts[6];
			return tokenInstance.transfer(fromAccount, 700, 
				{from : accounts[2]}); 
		}).then(function(receipt) {
			//Approve spending accounts to spend 100 tokens
			return tokenInstance.approve(callingAccount, 100,
				 {from : fromAccount});
		}).then(function(receipt) {
			//try transfering larger then allowed
			return tokenInstance.transferFrom(fromAccount, toAccount, 100, 
				{from : callingAccount});
		})
		// }).then(function(success) {
		// 	assert.equal(success, true, "transferFrom() returned false");
		// });
		.then(function(success) {
			assert.equal(success, true, "Tranfer from did not went well");
		});

	});



});