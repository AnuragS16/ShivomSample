pragma solidity ^0.4.18;

contract PermissionContract
{
    /* define variable owner of the tyep address*/
    address public owner;
    string value = "No Permission";
    
    struct ExternalUser {
        string fname;
        uint key;
        uint balance;
    }
    
    mapping (address => ExternalUser) externalUsers;
    
    struct RequestPermission{
        address for_address;
        uint permission; // 0 no permission, 1 permission requested, 2 permission granted
    } 
    
    mapping (address => RequestPermission)  requestPermission;
    
    
    struct GrantPermission{
        address for_address;
        uint permission; // 0 no permission, 1 permission granted
    } 
    
    
    mapping (address => GrantPermission)  grantPermission;
    
    
    /*
    saveDetails method to save all users details on system e.g firstname, publick key and bitcoin balance 
    */
    function saveDetails(address _address, string _fname, uint _lkey,uint _balance) public{
        var externalUser= externalUsers[_address];
        externalUser.fname = _fname;
        externalUser.key = _lkey;
        externalUser.balance = _balance;
    } 
   
    /*
    requestAccessPermission method allows an address to get view persimmion for other public address
    */
    function requestAccessPermission(address _from_address, address _which_address)  public{
       var reqpermission = requestPermission[_from_address];
        reqpermission.for_address = _which_address;
        
        var grntpermission = grantPermission[_which_address];
        grntpermission.for_address = _from_address;
    }
    
   
   /*
    approveRequest method allows apprpver to give read permision to other public address
    */
    function approveRequest(address _address) public returns(address,uint,address,uint){
        
        address temp = grantPermission[_address].for_address;
        uint tmpper = grantPermission[_address].permission;
        
        if(tmpper == 0)
        {
            tmpper = 1;
        }
        
        grantPermission[_address].permission = tmpper;
        
         address temp1 = requestPermission[temp].for_address;
        uint tmpper1 = requestPermission[temp].permission;
        return (temp,tmpper,temp1,tmpper1);
    }
    
    /*
    other approved public address can access any user's data based on permission
    */
    function AccessUserDetails(address _address) view public returns (string,uint,uint)
    {
        //address tmpaddr = grantPermission[_address].for_address;
        uint tmpper = grantPermission[_address].permission;
        
        //string  name = "no permission";
        uint _key;
        uint _balance;
        if(tmpper == 1){
            value =  externalUsers[_address].fname;
            _key = externalUsers[_address].key;
            _balance = externalUsers[_address].balance;
        }
        
        return(value,_key,_balance);
    }
    
   
    
    /* this function is executed at initialization and sets the owner of the contract */
    function PermissionContract() public {
        owner = msg.sender;
    }
    
   
    
    /* Function to recover the funds on the contract. owner of the contract can call this function */
    function kill() public{
        
        if(msg.sender == owner){
            selfdestruct(owner);
        }
    }
}

