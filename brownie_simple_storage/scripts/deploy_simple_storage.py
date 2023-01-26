from brownie import accounts, SimpleStorage

def deploy_simple_storage():
    account = accounts[0]
    simple_storage = SimpleStorage.deploy({"from": account})
    print(simple_storage)
    # now we would like to interact with the contract
    value = simple_storage.retrieve()
    print(value)
    # change the value
    transaction = simple_storage.store(15, {"from": account})
    transaction.wait(1) # this is for how many blocks we want to wait - not seconds
    updated_value = simple_storage.retrieve()
    print(updated_value)

def main():
    print("Deploying SimpleStorage...")
    deploy_simple_storage()


