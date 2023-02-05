// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract FileContract {
    uint256 public paperId;
    uint256 public citeFee;
    mapping(address => bool) AdminList;
    mapping(uint256 => Paper) Papers;
    mapping(address => uint256) PaperBalance;
    mapping(address => uint256) public AuthorBalance;
    mapping(address => string) public AuthorIntro;
    constructor(uint256 _citeFee) {
        citeFee = _citeFee;
    }

    struct Paper {
        string paperName;
        string paperCid;
        uint256 citedCount;
        uint256 publishTime;
        uint256 paperId;
        address author;
        uint256[] citeTargetList;
    }

    modifier onlyOwner() {
        require(AdminList[msg.sender]);
        _;
    }

    function paperIdExist(uint256 _paperId) internal returns (bool) {
        return _paperId <= paperId;
    }

    function getPaperBalance(address _address) public view returns (uint256) {
        return PaperBalance[_address];
    }


    function getCitedCount(uint256 _paperId) public view returns (uint256) {
        return Papers[_paperId].citedCount;
    }

    function getCiteCount(uint256 _paperId) public view returns (uint256) {
        return Papers[_paperId].citeTargetList.length;
    }

    function publishPaper(
        string memory paperName,
        string memory paperCid,
        uint256[] memory citeTargetList
    ) public payable {
        // tudo get elder paper
        require(msg.value>=citeFee*citeTargetList.length,"fee not enough");
        

        for (uint256 i; i < citeTargetList.length; i++) {
            require(paperIdExist(citeTargetList[i]));
            Papers[citeTargetList[i]].citedCount++;
            payable(Papers[citeTargetList[i]].author).transfer(citeFee);
            AuthorBalance[Papers[citeTargetList[i]].author]+=citeFee;
        }

        Papers[paperId] = Paper(
            paperName,
            paperCid,
            0,
            block.timestamp,
            paperId,
            msg.sender,
            citeTargetList
        );
        PaperBalance[msg.sender]++;
        paperId += 1;
    }

    function getPaper(uint256 _paperId) external view returns (Paper memory) {
        require(_paperId < paperId, "paper not exist");
        return Papers[_paperId];
    }


    function getPaperList() external view returns (Paper[] memory) {
        uint256 paperCount = PaperBalance[msg.sender];
        Paper[] memory paperList = new Paper[](paperCount);
        uint256 i;
        uint256 index;
        while (i < paperCount) {
            if (Papers[index].author == msg.sender) {
                paperList[i] = Papers[index];
                i++;
            }
            index++;
        }
        return paperList;
    }

    function getAllPaper() external view returns(Paper[] memory){
        Paper[] memory paperList = new Paper[](paperId);
        for(uint256 i;i<paperId;i++){
            paperList[i] = Papers[i];
        }
        return paperList;
    }

    function setAdmin(address _address, bool _bool) external onlyOwner {
        AdminList[_address] = _bool;
    }

    function setCiteFee(uint256 price) external onlyOwner {
        citeFee = price;
    }

    function setAuthorIntro(string memory _introCid) external {
        AuthorIntro[msg.sender] = _introCid;
    }
}
