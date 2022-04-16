// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We need to import the helper functions from the contract that we copy/pasted.
import {Base64} from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string partTwo =
        ";}</style></defs><path class='cls-1' d='M515.5,550.67v-30h30v30Zm12.91-13.84.07,0c0,.05,0,.11-.07.14-.2.17-.4.34-.61.49a.19.19,0,0,1-.19,0,.4.4,0,0,0-.55,0l-1.12.91c-.62.52-1.26,1-1.88,1.54-.18.14-.18.24,0,.41s.49.6.73.91c.11.14.15.14.29,0l1.24-1,1.84-1.5a.39.39,0,0,0,.14-.51.17.17,0,0,1,.06-.22c.15-.11.29-.23.43-.35s.22-.18.41,0a3.7,3.7,0,0,0,2.31,1.2,4,4,0,0,0,2.15-.25,4.36,4.36,0,0,0,2.52-5c0-.26-.15-.51-.23-.78h.54v4.69h1.29v-.19c0-1.44,0-2.88,0-4.32,0-.16,0-.2.2-.19h1.66c0-.28,0-.54,0-.8s-.05-.19-.19-.19h-3.9a.53.53,0,0,1-.39-.16,5.9,5.9,0,0,0-.8-.7,4,4,0,0,0-3.25-.55,4,4,0,0,0-2.2,1.45,5.24,5.24,0,0,0-.55.91,9.32,9.32,0,0,0-.34.87l-1-2h-.06l-2.89,5.9h1.15a.29.29,0,0,0,.13-.12,6.07,6.07,0,0,0,.24-.59.21.21,0,0,1,.22-.16H528a.47.47,0,0,1,.17,0Zm-3.74-2.55h-1.55s-.13,0-.13-.08c0-.41,0-.82,0-1.26h1.87c.11,0,.15,0,.15-.15s0-.5,0-.74,0-.17-.17-.17H521.9c-.15,0-.18.05-.18.19,0,1.78,0,3.56,0,5.34a1,1,0,0,0,0,.17H523v-2.26h1.69Z' transform='translate(-515.5 -520.67)'/><path d='M528.41,536.83l-.25-.07a.47.47,0,0,0-.17,0h-2.2a.21.21,0,0,0-.22.16,6.07,6.07,0,0,1-.24.59.29.29,0,0,1-.13.12h-1.15l2.89-5.9H527l1,2a9.32,9.32,0,0,1,.34-.87,5.24,5.24,0,0,1,.55-.91,4,4,0,0,1,2.2-1.45,4,4,0,0,1,3.25.55,5.9,5.9,0,0,1,.8.7.53.53,0,0,0,.39.16h3.9c.14,0,.2,0,.19.19s0,.52,0,.8h-1.66c-.15,0-.2,0-.2.19,0,1.44,0,2.88,0,4.32v.19h-1.29V532.9h-.54c.08.27.18.52.23.78a4.36,4.36,0,0,1-2.52,5,4,4,0,0,1-2.15.25,3.7,3.7,0,0,1-2.31-1.2c-.19-.2-.19-.2-.41,0s-.28.24-.43.35a.17.17,0,0,0-.06.22.39.39,0,0,1-.14.51l-1.84,1.5-1.24,1c-.14.11-.18.11-.29,0-.24-.31-.48-.61-.73-.91s-.14-.27,0-.41c.62-.51,1.26-1,1.88-1.54l1.12-.91a.4.4,0,0,1,.55,0,.19.19,0,0,0,.19,0c.21-.15.41-.32.61-.49,0,0,0-.09.07-.14Zm3.67-6.05c-.22,0-.45,0-.67.05a3.91,3.91,0,0,0-3.07,3.4,4,4,0,0,0,.56,2.49,3.58,3.58,0,0,0,2.52,1.76,3.53,3.53,0,0,0,3.11-.89,3.86,3.86,0,0,0,1.27-2.41,4,4,0,0,0-.28-2.06A3.77,3.77,0,0,0,532.08,530.78Zm-5.15,3h0l-.86,2h1.78Z' transform='translate(-515.5 -520.67)'/><path d='M524.67,534.28v1.05H523v2.26h-1.24a1,1,0,0,1,0-.17c0-1.78,0-3.56,0-5.34,0-.14,0-.19.18-.19h2.93c.12,0,.18,0,.17.17s0,.49,0,.74,0,.15-.15.15H523c0,.44,0,.85,0,1.26,0,0,.08.08.13.08h1.55Z' transform='translate(-515.5 -520.67)'/><path class='cls-1' d='M532.08,530.78a3.77,3.77,0,0,1,3.44,2.34,4,4,0,0,1,.28,2.06,3.86,3.86,0,0,1-1.27,2.41,3.53,3.53,0,0,1-3.11.89,3.58,3.58,0,0,1-2.52-1.76,4,4,0,0,1-.56-2.49,3.91,3.91,0,0,1,3.07-3.4C531.63,530.79,531.86,530.8,532.08,530.78Zm-1.86,5.31v.2c0,.39,0,.79.07,1.18a.15.15,0,0,0,.14.16c.12,0,.23.06.35.09a3.17,3.17,0,0,0,2,0,1.78,1.78,0,0,0,.29-3.23c-.38-.25-.8-.45-1.19-.69a1.66,1.66,0,0,1-.34-.25.44.44,0,0,1,.11-.73.76.76,0,0,1,.33-.08,2.45,2.45,0,0,1,1.18.34l.35.19c0-.43,0-.82,0-1.2a.2.2,0,0,0-.13-.15,3.7,3.7,0,0,0-2-.17,1.56,1.56,0,0,0-1.18,1.93,1.82,1.82,0,0,0,.89,1.1c.39.24.79.46,1.18.69a.75.75,0,0,1,.4.52.59.59,0,0,1-.59.67,2.19,2.19,0,0,1-1.35-.25Z' transform='translate(-515.5 -520.67)'/><path class='cls-1' d='M526.93,533.82l.87,2H526l.86-2Z' transform='translate(-515.5 -520.67)'/><path d='M530.22,536.09l.51.28a2.19,2.19,0,0,0,1.35.25.59.59,0,0,0,.59-.67.75.75,0,0,0-.4-.52c-.39-.23-.79-.45-1.18-.69a1.82,1.82,0,0,1-.89-1.1,1.56,1.56,0,0,1,1.18-1.93,3.7,3.7,0,0,1,2,.17.2.2,0,0,1,.13.15c0,.38,0,.77,0,1.2l-.35-.19a2.45,2.45,0,0,0-1.18-.34.76.76,0,0,0-.33.08.44.44,0,0,0-.11.73,1.66,1.66,0,0,0,.34.25c.39.24.81.44,1.19.69a1.78,1.78,0,0,1-.29,3.23,3.17,3.17,0,0,1-2,0c-.12,0-.23-.07-.35-.09a.15.15,0,0,1-.14-.16c0-.39,0-.79-.07-1.18Z' transform='translate(-515.5 -520.67)'/></svg>";

    string partOne =
        "<svg id='Layer_1' data-name='Layer 1' xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'><defs><style>.cls-1{fill:#";

    string[] arrayASCII = [
        "0",
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "a",
        "b",
        "c",
        "d",
        "e",
        "f",
        "g",
        "h",
        "i",
        "j",
        "k",
        "l",
        "m",
        "n",
        "o",
        "p",
        "q",
        "r",
        "s",
        "t",
        "u",
        "v",
        "w",
        "x",
        "y",
        "z"
    ];

    constructor() ERC721("FASTBLOCKCHAIN", "CPPFAST") {
        console.log("This is my NFT contract. Woah!");
    }

    // function pickRandomFirstWord(uint256 tokenId)
    //     public
    //     view
    //     returns (string memory)
    // {
    //     uint256 rand = random(
    //         string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId)))
    //     );
    //     rand = rand % firstWords.length;
    //     return firstWords[rand];
    // }

    function randomBackgroundColor(uint256 tokenId)
        public
        view
        returns (string memory)
    {
        string memory finalBackgroundColor; 

        for (int i = 0; i < 3; i++){
            uint256 rand = random(string(abi.encodePacked("arrayASCII", Strings.toString(tokenId))));
            rand = rand % arrayASCII.length;
            finalBackgroundColor += arrayASCII[rand];
        ) 
        return finalBackgroundColor;

        }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        uint256 newItemId = _tokenIds.current();

        string memory finalSvg = string(abi.encodePacked(partOne + randomBackgroundColor(newItemId) + partTwo));

        // Get all the JSON metadata in place and base64 encode it.
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        // We set the title of our NFT as the generated word.
                        finalSvg,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        // We add data:image/svg+xml;base64 and then append our base64 encode our svg.
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        // Just like before, we prepend data:application/json;base64, to our data.
        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(finalTokenUri);
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);

        // Update your URI!!!
        _setTokenURI(newItemId, finalTokenUri);

        _tokenIds.increment();
        console.log(
            "An NFT w/ ID %s has been minted to %s",
            newItemId,
            msg.sender
        );
    }
}
