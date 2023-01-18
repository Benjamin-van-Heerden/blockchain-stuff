// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract SimpleStorage {

    // this will get initialized to 0
    uint256 favoriteNumber;
    bool favoriteBool;

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    // this array is dynamic specifying
    Person[] public people;
    // mappings in sol have default values, for uint256 it's 0
    mapping(string => uint256) public nameToFavoriteNumber;

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

}

// what if we want to have many instances of this contract?
