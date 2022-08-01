// SPDX-License-Identifier: UNLICENSED;

pragma solidity ^0.8.0;

contract NewTicket {

    event ticketCreated(uint ticketId, uint refNo, address authority, string link);

    struct Ticket {
        uint refNo;
        address authority;
        string link;
    }

    Ticket[] public tickets;

    mapping(uint => address) public ticketToOwner;
    mapping(address => uint) public ticketUnderAuthority;
    mapping(uint => bool) public ticketStatus;
    // **********implement ***********//

    function _createTicket(uint _refNo, address _authority, string memory _link) private { 
        tickets.push(Ticket(_refNo, _authority, _link));
        uint Id = tickets.length;
        ticketToOwner[_refNo] = msg.sender;
        ticketUnderAuthority[_authority]++;
        emit ticketCreated(Id, _refNo, _authority, _link);
    }

    function generateRefNo(string memory _str) private view returns (uint) {
        uint NewRefNo = uint(keccak256(abi.encodePacked(_str)));
        return NewRefNo;
    }

    function createNewTicket(address _authority, string memory _link) public {
        uint RefNo = generateRefNo(_link);
        _createTicket(RefNo, _authority, _link);
    }
}
