
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18; // solidity version - informando a versão do solidity
// "^" allow the compiler to use the informed version or above - permite o compilador usar a versão informada ou superior

contract SimpleStorage {
    uint256 public myfavoriteNumber;  // uint256 - only positive integer numbers - 256 is the amount of bits (NOT bytes)
                                    // if the number isn't declared, is set the value 0
    
    // uint256[] mylistOfFavoriteNumbers;
    // the bracket ([]) inform that is a list/array Example: [0, 15, 68, ...]
    // Without specifying the number of list/array, is an Dynamic Array, can grow and shrink as it is used
    // Ex: Person[2] - the list Person can have any size up to 2 - called Static Array

    // using "struct" is a way to create personalize variable
    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    // After creating our personalize variable, we declare it as list/array
    Person[] public listOfPeople;

    function store(uint256 my_favoriteNumber) public {
        myfavoriteNumber = my_favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return myfavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        listOfPeople.push( Person(_favoriteNumber, _name)); // Solidity first run inside the parenteses than do the push
    }
}