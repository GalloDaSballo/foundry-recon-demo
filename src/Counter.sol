// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract Oracle {
    uint256 public price;
    uint256 public updatedAt;

    uint256 public prevPrice;
    uint256 public prevUpdatedAt;
    bool public reverts; // Reverts by throwing

    uint256 public MAX_CHANGE = 1.2e18; // change by up 20%

    uint256 public MAGNITUDE = 100;
    uint256 public MAX_MAGNITUDE = 50;
    

    function setPrice(uint256 newPrice) external {
        price = newPrice;
    }
    function setUpdatedAt(uint256 newUpdatedAt) external {
        updatedAt = newUpdatedAt;
    }

    function setPrevPrice(uint256 newPrice) external {
        prevPrice = newPrice;
    }
    function setPrevUpdatedAt(uint256 newUpdatedAt) external {
        prevUpdatedAt = newUpdatedAt;
    }

    function setReverts(bool newReverts) external {
        reverts = newReverts;
    }

    function fetchPrice() external returns (uint256) {
        if(isDeviated()) {
            revert("Deviation");
        }

        if(reverts) {
            revert("Reverted");
        }

        return (price + prevPrice) / 2;
    }

    // Clamping
    // 

    function isDeviated() public returns (bool) {
        price * MAGNITUDE / prevPrice > MAX_MAGNITUDE;
    }

     
}
