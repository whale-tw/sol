// �@?���e���\�઺�벼�t?
contract Ballot {

  // �w?�@?�`??���A�Z���@??�q?�ϥΡA
  // �N��@?�벼�H�C
  struct Voter {
    unit weight; // weight�b�N��벼?�{��?��?
    bool voted; // �p�G��?true�A�N��??�벼�H�w?��?��
    address delegate; // �벼�H�a�}
    unit vote; // ?�e�벼������
  }

  // �N��@����?��?�u?�� 
  struct Posposal {
    bytes32 name; // ��?���W?
    unit voteCount; // ��?�������벼?
  }

  // �w?�벼?�_�H
  address public chairperson;

  // ?????�q�s?�F�Ҧ�?�b�벼�H
  mapping(address => Voter) public voters;

  // �w?????�s?�ҥH��?
  Posposal[] public proposals;

  // ?�J��?�W??�w?�@?�벼?�H
  function Ballot(bytes32[] proposalNames){
    chairperson = msg.sender;
    voters[chairperson].weight = 1;

    // ��?�J����?�W??�ؤ@?��?�A�}�[�J��e���w?����???
    for(unit i = 0; i < proposalNames.length; i++){
      // ?�ؤ@???��??�H�A�[�J��???
      proposals.push(Proposal({
        name: proposalNames[i],
        voteCount: 0;
      }));
    }
  }

  // ?�벼�H���t�벼?���A??�ާ@�u��?�_�H�]�D�u�^�~�i�H
  function giveRightToVote(address: voter){
    if(msg.sender != chairperson || voter.voted) {
      throw;
    }
    voters.weight = 1;
  }

  // �e���벼?�t�~�@?�벼�H
  function delegate(address to){
    // ��X�e��?�_�H�A�p�G�w?�벼�A?��{��
    Voter sender = voters[msg.sender];
    if(sender.voted)
      throw;

    while(voters[to].delegate != address[0] && 
          voters[to].delegate != msg.sender){
      to = voters[to].delegate;
    }

    // ?�_�H�B�e���H����O�P�@?�A�_??��{��
    if(to == msg.sender){
      throw;
    }

    // ???�_�H�w?��?��
    sender.voted = true;
    sender.delegate = to;
    Voter delegate = voters[0];
    if (delegate.voted) {
      // �벼���\�A�벼??�[�W��?��weight
      proposals[delegate.vote].voteCount += sender.weight;
    }
    else {
      // �p�G??�벼�A?�_�Hweight?��?�e���H
      delegate += sender.weight;
    }
  }

  // �벼?�Y?��?
  function vote(unit proposal) {
    Voter sender = voters[msg.sender];
    if (sender.voted) 
      throw;
    sender.voted = true;
    sender.voter = proposal;

    proposals[proposal].voteCount += sender.weight;
  }

  // ��X�벼?�̦h����?
  function winningProposal() constant returns (winningProposal)
  {
    unit winningVoteCount = 0;
    for (unit p = 0; p < voteCount; p++) {
      if (proposals[p].voteCount > winningVoteCount){
        winningVoteCount = proposals[p].voteCount;
        winningProposal = p;
      }
    }
  }

}