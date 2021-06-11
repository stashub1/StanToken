const Web3 = require("web3");
const ICOjson = require("./build/contracts/ICO.json");
const ICOaddress = ICOjson.networks[5777].address;
const TokenJson = require("./build/contracts/Token.json");
const TokenAddress = TokenJson.networks[5777].address;




async function init() {
	const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
	const accounts = await web3.eth.getAccounts();
	console.log(accounts);


	const tokenContract = await new web3.eth.Contract(TokenJson.abi, TokenAddress);
	var balance = await tokenContract.methods.balanceOf("0x8dC26238CF9726605200b29fB1DFAcc31EE6f501").call();
	console.log("Balance : "+ balance);
	console.log("admin address: " + await tokenContract.methods.admin().call());

	let to = "0xD8Ce37FA3A1A61623705dac5dCb708Bb5eb9a125";
	let rec = await tokenContract.methods.transfer(to, 1)
		.send({from : "0xF713789Ae84D152A130Df79231d1223637F1f417"});

	console.log("Receipt: ", rec);
	console.log("Events: ", rec.events.Transfer.returnValues);
	console.log("admin address: " + await tokenContract.methods.admin().call());


	var balanceNew = await tokenContract.methods.balanceOf("0x8dC26238CF9726605200b29fB1DFAcc31EE6f501").call();
	console.log("balanceNew : " + balanceNew);


	console.log("balance Of Receiver : "+ await tokenContract.methods.balanceOf(to).call());

	// const icoContract = await new web3.eth.Contract(ICOjson.abi, ICOaddress);
	
	// await checkBalances(icoContract);

	// await buyToken("0x2760D74010925FB6714AB6665e899a23e832D71F", 10, icoContract);
	// await buyToken("0x8dC26238CF9726605200b29fB1DFAcc31EE6f501", 20, icoContract);

	// await checkBalances(icoContract);

	// try {
	// 	let admin = await icoContract.methods.admin().call();
	// 	console.log("admin : " + admin);
	// } catch (e) {
	// 	console.log(e);
	// }

	// checkTokenSupply(icoContract);

	// addTokensLeft("0x8dC26238CF9726605200b29fB1DFAcc31EE6f501", 100, icoContract);
	
	// checkTokenSupply(icoContract);


}

async function buyToken( adr,  amount, contract) {
	try {

		await contract.methods.buyToken(amount)
		.send({from : adr, 
			   value : amount/10});
		console.log("---Purchase completed for address " + adr);
	} catch (e) {
		console.log(e);
	}	
}

async function addTokensLeft(adr, amount, icoContract) {
	try {
		const quantity = 100;
		await icoContract.methods.addTokensLeft(amount)
			.send({from : adr});
		console.log("---Tokens quantity updated successfully on "  + amount);
	} catch (e) {
		console.log(e);
	}	


}

async function checkBalances(contract) {
	const balance125 = await contract.methods.balanceOf("0xD8Ce37FA3A1A61623705dac5dCb708Bb5eb9a125").call();
	console.log("Token balance 0xD8Ce37FA3A1A61623705dac5dCb708Bb5eb9a125: ", balance125);

	const balance71F = await contract.methods.balanceOf("0x2760D74010925FB6714AB6665e899a23e832D71F").call();
	console.log("Token balance 0x2760D74010925FB6714AB6665e899a23e832D71F: ", balance71F);

	const balance501 = await contract.methods.balanceOf("0x8dC26238CF9726605200b29fB1DFAcc31EE6f501").call();
	console.log("Token balance 0x8dC26238CF9726605200b29fB1DFAcc31EE6f501: ", balance501);
}

async function checkTokenSupply(contract) {
	const tokensLeft = await contract.methods.tokensLeft().call();
	console.log("Rest of tokens", tokensLeft);

	const initialSupply = await contract.methods.totalSupply().call();
	console.log("Initial supply", initialSupply);
}

init();