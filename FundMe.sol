//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // this is the interface for the chainlink oracle
// on a real project, we would use the npm package to import the interface, here we are just using the interface directly
interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(uint80 _roundId)
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );

  function latestRoundData()
    external
    view
    returns (
      uint80 roundId,
      int256 answer,
      uint256 startedAt,
      uint256 updatedAt,
      uint80 answeredInRound
    );
}


contract FundMe {
    mapping(address => uint256) public addressToAmountFunded;

    // functions that are specified as payable can be used to send ether to the contract
    function fund() public payable {
        // the msg object is a global object that contains information about the function call
        // msg.sender is the address of the person who called the function
        // msg.value is the amount of ether that was sent to the contract
        addressToAmountFunded[msg.sender] += msg.value;
        // the contract will become the owner of the amount of ether that was sent to it!!
        // it can then use that ether to do whatever it wants
    }

    function getVersion() public view returns (uint256) {
        // the price feed address can be found on the chainlink website https://docs.chain.link/data-feeds/price-feeds/addresses/
        // on each chain the address is different - this one is on Goerli
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        return priceFeed.version();
    }

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        );
        // the getRoundData function returns a tuple with the following fields:
        // roundId: the round ID
        // answer: the price
        // startedAt: the timestamp when the round started
        // updatedAt: the timestamp when the round was updated
        // answeredInRound: the round ID of the round where the answer was computed from
        // this is how we work with tuples in Solidity 
        (, int256 answer, , , ) = priceFeed.latestRoundData();
        return uint256(answer) * uint256(priceFeed.decimals()); // this will return the price in USD to WEI
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        return (ethPrice * ethAmount) / 1e18;
    }

    function fundMin() public payable {
        // suppose we want to make sure a minumum amount of USD is sent to the contract
        // how do we get the current USD price of ether?
        // this is exactly where oracles come in to play
        // oracles are ways for a contract to get information from the outside world 

        // say 50$
        uint256 minimumUSD = 50 * 1e18;
        require(
            getConversionRate(msg.value) >= minimumUSD,
            "You need to spend more ETH!"
        );



    }

}