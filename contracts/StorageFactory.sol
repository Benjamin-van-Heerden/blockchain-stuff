//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "./SimpleStorage.sol";

// inheritance in Solidity is a way to create new contracts using existing contracts as building blocks
// it is specified using the keyword is
contract StorageFactory is SimpleStorage {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        SimpleStorage simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        // fetch the simple storage from the array, we want to make use of the store function
        // so we need to get the address of the contract and then cast it to the SimpleStorage type
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        // store the number in the simple storage
        simpleStorage.store(_simpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex)
        public
        view
        returns (uint256)
    {
        SimpleStorage simpleStorage = SimpleStorage(address(simpleStorageArray[_simpleStorageIndex]));
        return simpleStorage.retrieve();
    }
}