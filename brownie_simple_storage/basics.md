This project structure was generated from the `brownie init` command.

Brownie is a Python-based development and testing framework for smart contracts targeting the Ethereum Virtual Machine.

It allows you to manage projects, compile contracts, write tests, and interact with the blockchain.
It is designed to be easy to use and to integrate with other tools and workflows.

Lots of big players in the blockchain space use Brownie, including Aave, Curve, and Synthetix.

Once you have a contract, you can compile it with the `brownie compile` command.
This will compile all contracts in the `contracts/` directory and output the ABI and bytecode to the `build/` directory.

Brownie can also deploy contracts to the blockchain. To do this, you need to create a deployment script in the `scripts/` directory.
Brownie will automatically run any scripts it finds in this directory, so you can add as many as you like.
Once you have your deployment script, you can run it with the `brownie run` command.

Brownie natively knows how to work with accounts - test accounts can be obtained via `from brownie import accounts` then `accounts[0]`. This will return the first account in the list of accounts available to Brownie. Remember Brownie automatically spins up a ganache chain. 

If we want to add a new account, we can do so with `brownie accounts new <name>`. This will create a new account and save it to the `accounts.json` file in the project root. We will also be prompted to enter the private key for the account. This is the private key for the account that will be used to sign and deploy transactions. This is a secure way to store the private key, as it is not stored in plain text anywhere - Brownie password encrypts it before it is stored.

Removing an account is also trivial via `brownie accounts delete <name>`.

Working with a created account in our scripts is then done via `accounts.load("<name>")`. This will return the account object for the account with the given name. This will prompt a password every time it is run, as the private key is encrypted.

If you would rather work with environment variables, there is also functionality for that via the `brownie-config.yaml` file. Among other things, by setting `dotenv: .env` in this file, Brownie will automatically load the environment variables from the `.env` file in the project root. This is a good way to store sensitive information like private keys, as it is not stored in plain text anywhere. You can get access to anything in this yaml file via `from brownie import config`.

As stated, Brownie will automatically compile your contracts. It will then even allow you to import them into your scripts. This is done via `from brownie import SimpleStorage`. This will import the `SimpleStorage` contract into the script. This is a great way to interact with your contracts. It makes deployment much easier, as you can just call `SimpleStorage.deploy({"from": accounts[0]})` to deploy the contract. This will return the contract object, which you can then use to interact with the contract. 