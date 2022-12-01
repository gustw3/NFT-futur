// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/PullPayment.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";


contract Futur is ERC721URIStorage, PullPayment, Ownable {
		using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 public constant TOTAL_SUPPLY = 2;

    uint256 public constant MINT_PRICE = 0.001 ether;

    constructor() ERC721("Futur", "FT3") {
      console.log("Here is an NFT well deployed !");
    }

    function mint() public payable returns (uint256) {
      require(_tokenIds.current() < TOTAL_SUPPLY);
      //require(msg.value == MINT_PRICE);
      _tokenIds.increment();
      uint256 newTokenId = _tokenIds.current();
      _safeMint(msg.sender, newTokenId);
      _setTokenURI(newTokenId, "https://bafybeicohrkwvyyuhg4ai34n5t763pj65i22wzmepe5mnpldzx7ub7fl4q.ipfs.nftstorage.link/metadatas/1.json");
      return newTokenId;
    }

    // Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function whithdrawPayments(address payable payee) public payable onlyOwner {
        require(payee != address(0), "Wrong Payee");
        (bool sent, bytes memory data) = payee.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
