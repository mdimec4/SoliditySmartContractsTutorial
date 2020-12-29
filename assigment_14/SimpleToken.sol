pragma solidity ^0.7.0;

contract SimpleToken {
    address owner;
    mapping(address => uint256) public accounts;
    uint256 tokenSuply;
    uint256 constant weiConversion = 10**15;
    
    constructor(uint256 initialSuply) {
        owner = msg.sender;
        accounts[owner] = initialSuply;
        tokenSuply = initialSuply;
    }
    
    function transfer(address to, uint256 value) public {
        require(accounts[msg.sender] >= value);
        require(accounts[to] + value >= accounts[to]);
        accounts[msg.sender] -= value;
        accounts[to] += value;
    }
    
    function balanceOf(address _owner) view public returns(uint256) {
        return accounts[_owner];
    }
    
    function totalSuply() view public returns(uint256) {
        return tokenSuply;
    }

    // buy tokens with eth   
    function buy() public payable {
        require(msg.sender != owner);
        uint256 value = (msg.value/weiConversion);
        require(accounts[owner] >= value);
        accounts[owner] -= value;
        accounts[msg.sender] += value;
    }
    
    // call buy when eth is sent to the contract address
    receive() external payable {
        buy();
    }
    
    // send eth balance to the owner
    function withdraw() public payable {
        require(msg.sender == owner);
        payable(owner).transfer(address(this).balance);
    }
}
