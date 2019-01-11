/* Smart Contract to Grant Permission for a Public Address to access the Details 
   of the address. without permission any public address cant access the details of other user
*/

1. function saveDeatils()- to be called first to save the data of all users e.g. address, name, public key and Balance

2. function requestAccessPermission(requester address, approver address)- request to get permission for other account

3. function approveRequest(approver address) - approve the access permission for calling address

4. function AccessUserDeatails(viewprofile address) - access the details of the User after permission has been granted

5. Display Basic User details if view permission is given
