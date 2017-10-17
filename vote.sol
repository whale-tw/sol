// ?Τ〆Λщ布╰?
contract Ballot {

  // ﹚??蝋????秖?ㄏノ
  // ?щ布
  struct Voter {
    unit weight; // weightщ布?祘い?仓?
    bool voted; // 狦?true??щ布?щ?布
    address delegate; // щ布
    unit vote; // ?玡щ布ま
  }

  // 矗??誹?疼 
  struct Posposal {
    bytes32 name; // 矗??
    unit voteCount; // 矗?钡щ布?
  }

  // ﹚?щ布?癬
  address public chairperson;

  // ?????秖?┮Τ?щ布
  mapping(address => Voter) public voters;

  // ﹚??????┮矗?
  Posposal[] public proposals;

  // ?矗???﹚??щ布?禜
  function Ballot(bytes32[] proposalNames){
    chairperson = msg.sender;
    voters[chairperson].weight = 1;

    // р?矗????矗?玡﹚?矗???
    for(unit i = 0; i < proposalNames.length; i++){
      // ????矗??禜矗???
      proposals.push(Proposal({
        name: proposalNames[i],
        voteCount: 0;
      }));
    }
  }

  // ?щ布だ皌щ布???巨Τ?癬畊
  function giveRightToVote(address: voter){
    if(msg.sender != chairperson || voter.voted) {
      throw;
    }
    voters.weight = 1;
  }

  // 〆Λщ布??щ布
  function delegate(address to){
    // т〆Λ?癬狦?щ布?ゎ祘
    Voter sender = voters[msg.sender];
    if(sender.voted)
      throw;

    while(voters[to].delegate != address[0] && 
          voters[to].delegate != msg.sender){
      to = voters[to].delegate;
    }

    // ?癬〆Λぃ琌???ゎ祘
    if(to == msg.sender){
      throw;
    }

    // ???癬?щ?布
    sender.voted = true;
    sender.delegate = to;
    Voter delegate = voters[0];
    if (delegate.voted) {
      // щ布Θщ布???weight
      proposals[delegate.vote].voteCount += sender.weight;
    }
    else {
      // 狦??щ布?癬weight??〆Λ
      delegate += sender.weight;
    }
  }

  // щ布?琘?矗?
  function vote(unit proposal) {
    Voter sender = voters[msg.sender];
    if (sender.voted) 
      throw;
    sender.voted = true;
    sender.voter = proposal;

    proposals[proposal].voteCount += sender.weight;
  }

  // тщ布?程矗?
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