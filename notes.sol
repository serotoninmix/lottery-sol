// SPDX-License-Identifier: GLP-3.0

pragma solidity ^0.8.2;

/* or
pragma solidity >=0.5.0 <0.9.0;
*/

contract Property{
    // declaring state variables saved in contract's storage
    uint price; // by default is private
    string public location;
    
    // can be initialized at declaration or in the constructor only
    address immutable public owner; 
    
    // declaring a constant
    int constant area = 100;
    
    // declaring the constructor
    // is executed only once at contract's deployment
    constructor(uint _price, string memory _location){
        price = _price;
        location = _location;
        owner = msg.sender;  // initializing owner to the account's address that deploys the contract
    }
}
    
    // getter function, returns a state variable
    // a function declared `view` does not alter the blockchain 
    function getPrice() public view returns(uint){
        return price;
    }
    
    // setter function, sets a state variable
    function setPrice(uint _price) public{
        int a; // local variable saved on stack
        a = 10;
        price = _price;
    }
    
    function setLocation(string memory _location) public{ //string types must be declared memory or storage
        location = _location;
    }

    //Boolean types
    bool public sold;

    //Integer types
    uint8 public x = 255;
    //example: uint public x = 256; will be an error (cannot be over 255 using 8).

    int8 public y = -10;

    function f1() public {
        x +=1;
    }

    //Fixed-Size Arrays
contract FixedSizeArray{
    uint[3] public numbers = [2, 3, 4]; 
    //this example was an array literal;
    //Next: setter function to change the elements of the array
    function setElement(uint index, uint value) public{
        numbers[index] = value;
    }
    function getLength() public view returns(uint){
        return numbers.length;
    }
}
    //the elements of an array can be of any type, not just int/uint, so we'll do another case:
contract FixedSizeArray{
    bytes1 public b1;
    bytes2 public b2;
    bytes3 public b3;
    //up to bytes32;
    //in older versions, byte is alias for bytes1;

    //Next: setter function to change the elements of the array
    function setBytesArray() public{
        b1 = 'a';
        b2 = 'ab';
        b3 = 'abc';
    }
}
    //Dynamic-sized Arrays
contract DynamicArrays{
    uint[] public numbers;

    function getLength() public view returns(uint){
        return numbers.length;
    }

    function addElement(uint item) public{
        numbers.push(item);
    }
    //until this point the function cannot fetch the numbers; so we'll add:
    function getElement(uint i) public view returns(uint){
        if(i<numbers.length){
            return numbers[i];
        }
        return 0;
    }
    //another member of Dynamic Arrays besides strings is Pop, a function the removes an element from the end of the array;
    function popElement() public{
        numbers.pop();
    }
    //noting: a .push() has constant gas costs, because it's increasing the length of a storage. While pop() has costs depending on the size of the element being removed;
    //besides storage arrays, there's also Memory Arrays
    function f() public pure{
    //we can add 'pure' because it doesn't use the Blockchain;
        uint[] memory y = new uint[](3);
        y[0] = 10;
        y[1] = 20;
        y[2] = 30;
        numbers = y;
    }
}

//Dynamic Arrays: bytes & string arrays
contract bytesAndStrings{
    bytes public b1 = 'abc';
    string public s1 = 'abc';

    function addElement() public{
        b1.push('x');
        // s1.push('x') --- gives an error, we cannot add elements to strings.
    }

    function getElement(uint i) public view returns(bytes1){
        return b1[i];
        //again, cannot use s1

    }

    function getLength() public view returns(uint){
        return b1.lenght;
        //again, cannot use s1
    }
}

// Structs & Enums
struct Instructor{
    uint age;
    string name;
    address addr;
}

contract Academy{
    Instructor public academyInstructor;

    //enum
    enum State{Open, Closed, Unknown}
    State public academyState = State.Open;

    //struct

    constructor(uint _age, string memory _name){
        academyInstructor.age = _age;
        academyInstructor.name = _name;
        academyInstructor.addr = msg.sender;
    }

    function changeInstructor(uint _age, string memory _name, address _addr) public{
        //enum only:
        if(academyState == State.Open){

        //rest struct
        Instructor memory myInstructor = Instructor({
            age: _age,
            name: _name,
            addr: _addr
        }
            );
        academyInstructor = myInstructor;
    }
    //enum close function
    }
}

contract School{
    Instructor public schoolInstructor;
}

// Mapping

contract Auction{
    mapping(address => uint) public bids;

    function bid() payable public {
        bids[msg.sender] = msg.value;
        //msg.sender is the address that call the function in a transaction. msg.value is the value in wei sent when calling the function. These are global predifined in Solidity.
        
    }
}

// Storage vs. Memory
contract A{
   string[] public cities = ['Prague', 'Bucharest'];

   function f_memory() public{
    string[] memory s1 = cities;
    //this variable will be stored in Memory, not storage, and it's initialized with the state variable
    s1[0] = 'Berlin';
   } 

   function f_storage() public{
    string[] storage s1 = cities;
    //this variable will be stored in Storage, not memory, and it's initialized with the state variable
    s1[0] = 'Berlin';
   }    
}

//Global Variables

contract GlobalVariables{
    address public owner;
    constructor(){
        owner = msg.sender;
        //owner means contract of the account that calls the function.
    }

    function changeOwner() public{
        owner = msg.sender;
        //changes owner
    }

    function sendEther() public payable{
        sentValue = msg.value;
    }

    function getBalance() public view returns{
        return address(this).balance;
    }

    function howMuchGas() public view returns(uint){
        uint start = gasleft();
        uint j = 1;
        for(uint i=1; i<20; i++){
            j *= i;
        }
        uint end = gasleft();
        return start - end;
    }
}

//Other Global Variables

contract GlobalVars{
    uint public this_moment = block.timestamp;
    uint public block_number = block.number;
    uint public difficulty = block.difficulty; //difficulty of the problem
    uint public gasLimit = block.gaslimit; //current gas limit, defines the maximum gas price
}

//Contract Addresses

contract Deposit{
    address public owner;

    constructor(){
        owner = msg.sender;
    }
    receive() external payable{
    }

    fallback() external payable{
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    //sending ETH through a payable function

    function sendEther() public payable{
        uint x;
        x++;
    }

    //accessing contract's balance:
    function transferEther(address payable recipient, uint amount) public returns(bool){
        require(owner== msg.sender, "Transfer failed, you are not the owner!");

        if(amount <= getBalance()){
            recipient.transfer(amount);
            return true;
        } else{
            return false;
        }
    }
}

//Functions & Variables

contract A{
    int public x = 10;
    int y = 20;

    //public
    function get_y() public view returns(int){
        return y;
    }

    //private
    function f1() private view returns(int){
        return x;
    }

    function f2() public view returns(int){
        int a;
        a = f1();
        return a;
        //this will return f2 (which is now the same as f1), but it will never return f1 because it's private.
    }

    //internal
    function f3() internal view returns(int){
        return x;
    }

    //external -- more efficient in terms of gas consumption.
    function f4() external view returns(int){
        return x;
    }

    function f5() public pure returns(int){
        int b;
        return b;
    }
}

// Contract Planning and Design
// Lottery Smart Contract

/* Auction
Smart Contract for a Decentralized Auction like an eBay alternative;

● The Auction has an owner (the person who sells a good or service), a start and an end
date;
● The owner can cancel the auction if there is an emergency or can finalize the auction
after its end time;
● People are sending ETH by calling a function called placeBid(). The sender’s address
and the value sent to the auction will be stored in mapping variable called bids;
● Users are incentivized to bid the maximum they’re willing to pay, but they are not bound
to that full amount, but rather to the previous highest bid plus an increment. The
contract will automatically bid up to a given amount;
● The highestBindingBid is the selling price and the highestBidder the person who won the auction;
● After the auction ends the owner gets the highestBindingBid and everybody else
   withdraws their own amount;
 
The Auction Contract - The placeBid() function
bids[0x123...] = 40
bids[0xabc...] = 70
bidIncrement = 10
highestBidder = 0xabc... highestBindingBid = 50 ---------------------------------------------
0x123... is sending 100 wei
bids[0x123...] = 40 + 100= 140 highestBindingBid = min(140, 70+10) = 80
*/

//Example:

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.9.0;

contract Auction{
    address payable public owner;
    uint public startBlock;
    uint public endBlock;
    string public ipfsHash;
    
    enum State{Started, Running, Ended, Canceled}
    State public auctionState;

    uint public highestBindingBig;
    address payable public highestBidder;

    mapping(address => uint) public bids;
    uint bidIncrement;

constructor(){
    owner = payable(msg.sender);
    auctionState = State.Running;
    startBlock = block.number; //block.number global variable in solidity;
    //how many Ethereum blocks will be generated in a week? 1. How many seconds in a week? 60s*60m*24h*7 = 604,800seconds/week;
    //To calculate how many blocks we divide the seconds in a week per 15; So 604,800/15 = 40,320;
    endBlock = startBlock + 40320; //means that the auction will be running for a week;
    ipfsHash = "";
    bidIncrement = 100; //100 wei;
}

//there are a few restrictions for this: 1. we don't want the owner to be allowed to place a bid
//this could lead to someone increasing the price artificially. So we add this modifier:
modifier notOwner(){
    require(msg.sender != owner);
    _;
}

//2. the auction will be running only between the start and end blocks;

modifier afterStart(){
    require(block.number >= startBlock);
    _;
}

modifier beforeEnd(){
    require(block.number <= endBlock);
    _;
}

function min(uint a, uint b) pure internal returns(uint){
    if(a <= b){
        return a;
    } else{
        return b;
    }
}

//this is the main function of the auction:
function placeBid() public payable notOwner afterStart beforeEnd{
    require(auctionState == State.Running);
    require(msg.value >= 100);

    uint currentBid = bids[msg.sender] + msg.value;
    require(currentBid < highestBindingBig);

    bids[msg.sender] = currentBid;

    if(currentBid <= bids[highestBidder]){
        highestBindingBig = min(currentBid + bidIncrement + bids[highestBidder]);
    } else{
        highestBindingBig = min(currentBid + bids[highestBidder] + bidIncrement);
        highestBidder = payable(msg.sender);
    }
}


}

/* Function Modifiers 
● Function modifiers are used to modify the behaviour of a function. They test a condition before calling a function which will be executed only if the condition of the modifier evaluates to true;
● Using function modifiers you avoid redundant-code and possible errors;
● They are contract properties and are inherited;
● They don’t return and use only require();
● They are defined using the modifier keyword;
*/

//Example:

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.6.0 <0.9.0;

contract Property{
    uint public price;
    address public owner;

    //declaring the constructor
    constructor(){
        price = 0;
        owner = msg.sender;
    }

    //the modifier will make the rest of the contract have less redundant lines of code;
    modifier onlyOwner(){
        require(owner == msg.sender);
        _; //special sector;
    }

    function changeOwner(address _owner) public onlyOwner{
        owner = _owner;
    }

    function setPrice(uint _price) public onlyOwner{
        price = _price;
    }
}