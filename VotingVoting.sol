// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0; 
// ประกาศการโหวต
contract Voting {
    mapping (string => uint256) public votesReceived;
    string [] public candidateList;
//เอาไว้ดู Log ว่าใครโหวตใคร      
    event VoteReceived (address user, string candidate);
//อยากให้กำหนดว่าคนที่จะโหวตมีใครได้บ้าง ไม่ได้จำกัดแค่สองสามคนที่เรา Fix ไว้ contract นี้ไม่สามารถเพิ่มลด candidate ได้ ต้องเขียนโค้ดเพิ่ม    
    constructor(string[] memory candidateNames) {
        candidateList = candidateNames;
    }
// พอประกาศPublic จะทำตัว Public view ได้อัตโนมัติ สามารถดูได้โดยไม่เสียค่า Gas
    function totalVotesFor (string memory candidate) public view returns (uint256){
        return votesReceived[candidate];
    }

    function voteForCandidate (string memory candidate) public {
        votesReceived[candidate] += 1;

        emit VoteReceived(msg.sender, candidate);
    }

    function candidateCount() public view returns (uint256) {
        return candidateList.length;
    }
}
