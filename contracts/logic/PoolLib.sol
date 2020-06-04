pragma solidity ^0.4.23;



import 'openzeppelin-solidity/contracts/math/SafeMath.sol';

contract PoolLib {

  using SafeMath for uint256;

  //TODO move to lib
  function splitIntoBytes32(bytes byteArray, uint256 numBytes32) internal pure returns (bytes32[] memory bytes32Array,
                                                                                        bytes memory remainder) {
    if ( byteArray.length % 32 != 0 ||
         byteArray.length < numBytes32.mul(32) ||
         byteArray.length.div(32) > 50) { // Arbitrarily limiting this function to an array of 50 bytes32's to conserve gas

      bytes32Array = new bytes32[](0);
      remainder = new bytes(0);
      return;
    }

    bytes32Array = new bytes32[](numBytes32);
    bytes32 _bytes32;
    for (uint256 k = 32; k <= numBytes32 * 32; k = k.add(32)) {
      assembly {
        _bytes32 := mload(add(byteArray, k))
      }
      bytes32Array[k.sub(32).div(32)] = _bytes32;
    }

    uint256 newArraySize = byteArray.length.div(32).sub(numBytes32).mul(32);
    remainder = new bytes(newArraySize);

    bytes1 _bytes1;
    uint256 offset = numBytes32.sub(1).mul(32).add(64);
    for (uint256 i = offset; i < newArraySize.add(offset); i = i.add(1)) {
      assembly {
        _bytes1 := mload(add(byteArray, i))
      }
      remainder[i.sub(offset)] = _bytes1;
    }
  }

  //TODO use SafeMath and move to lib
  function addressToString(address x) internal pure returns (string) {
    bytes memory s = new bytes(40);
    for (uint256 i = 0; i < 20; i++) {
      byte b = byte(uint8(uint256(x) / (2**(8*(19 - i)))));
      byte hi = byte(uint8(b) / 16);
      byte lo = byte(uint8(b) - 16 * uint8(hi));
      s[2*i] = char(hi);
      s[2*i+1] = char(lo);
    }
    return string(s);
  }

  //TODO use SafeMath and move to lib
  function char(byte b) internal pure returns (byte c) {
    if (b < 10) return byte(uint8(b) + 0x30);
    else return byte(uint8(b) + 0x57);
  }

  //TODO use SafeMath and move to lib
  function uintToString(uint256 v) internal pure returns (string) {
    uint256 maxlength = 80; // 2^256 = 1.157920892E77
    bytes memory reversed = new bytes(maxlength);
    uint256 i = 0;
    while (v != 0) {
      uint256 remainder = v % 10;
      v = v / 10;
      reversed[i++] = byte(48 + remainder);
    }
    bytes memory s = new bytes(i);
    for (uint256 j = 0; j < i; j++) {
      s[j] = reversed[i - 1 - j];
    }
    return string(s);
  }
}
