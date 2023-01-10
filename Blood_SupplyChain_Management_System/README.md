```bash 
for etherscan visit here : 
https://goerli.etherscan.io/address/0x871e13729c1a405412a94efff6a7286d395793d0
```
# Blood Supply Management system

This Solidity smart contract is designed to manage the supply of blood within a hospital system. It allows hospitals and blood suppliers to be added to the system, and tracks the movement of blood from suppliers to hospitals and ultimately to patients. The contract includes several functions and events to facilitate these actions, as well as modifiers to enforce permissions and ensure that only authorized entities can perform certain actions.
It has functions for adding blood donors, suppliers, hospitals, and patients. It also has functions for shipping blood from a supplier to a hospital and for using blood by a patient at a hospital.
The contract also has several structs for storing information about donors, blood units, suppliers, hospitals, and patients. It has mappings for storing this information, and events for logging when certain actions take place. Finally, it has several modifiers that check if the caller of a function is the contract owner, a registered supplier, a registered hospital, or has permission to ship blood to a particular hospital.

 ## Functionalities :

 ## Adding Suppliers and Hospitals 
 Only the contract owner can add new blood suppliers and hospitals to the system. Once added, these entities are stored in mapping structures and are also added to their respective arrays (suppliers and hospitals).
 
 ## Donating Blood 
 Donors can donate blood by calling the addDonor function, which records their personal information (such as name, age, and blood group) and the amount of blood donated. The blood's status is initially set to pending, meaning it has not yet been shipped to a hospital. 

 ## Shipping Blood
 Suppliers can ship blood to hospitals by calling the shipBlood function. This function updates the blood's status to Shipped and records the shipping time.
 
 ## Using Blood
 Hospitals can use blood by calling the useBlood function. This function updates the blood's status to Fulfilled and records the time at which it was used. 


# Functions 
Here is a description of each function:

- addSupplier: Allows the owner of the contract to add a new supplier to the system. The function takes an address and the name of the organization as inputs. It stores the supplier's address and organization name, and adds the address to the list of suppliers.

- addHospital: Allows the owner of the contract to add a new hospital to the system. The function takes an address and the name of the hospital as inputs. It stores the hospital's address and name, and adds the address to the list of hospitals.

- addDonor: Allows a supplier to add a new blood donor to the system. The function takes the donor's name, age, gender, address, blood group, and blood volume as inputs. It stores the donor's information and adds the blood to the system with a unique ID.

- shipBlood: Allows a supplier to ship blood from their organization to a hospital. The function takes the blood's unique ID and the address of the hospital as inputs. It updates the blood's status to "shipped" and records the shipping time.

- useBloodByPatient: Allows a hospital to use blood for a patient. The function takes the blood's unique ID and the patient's    information as inputs. It updates the blood's status to "fulfilled" and records the time the blood was used.

- getDonor: Returns the information of a blood donor given the donor's unique ID.

- getBlood: Returns the information of a blood unit given the blood's unique ID.

- getSupplier: Returns the information of a supplier given the supplier's unique ID.

- getHospital: Returns the information of a hospital given the hospital's unique ID.

- getPatient: Returns the information of a patient given the patient's unique ID.



 # Events 
 The contract includes several events that are emitted at various points throughout its execution. These events include: 
- eventBloodAdded: This event is emitted when a new blood donor is added to the system. 
  It includes the blood's unique ID, blood group, volume, and donation time.
- eventSupplierAdded: This event is emitted when a new blood supplier is added to the system. 
  It includes the supplier's address and organization name, as well as the time at which they were added.
- eventHospitalAdded: This event is emitted when a new hospital is added to the system. 
 It includes the hospital's address and name, as well as the time at which they were added.
- eventBloodShipped: This event is emitted when blood is shipped from a supplier to a hospital. 
  It includes the supplier's address, the blood's ID, the hospital's address, and the shipping time.
- eventBloodUsedByPatient: emitted when blood is used by a patient at a hospital

## Modifiers
The contract includes several modifiers that are used to enforce permissions and ensure that only authorized entities can perform certain actions. These modifiers include:

- checkOwner: can only be called by the contract owner
- checkSupplier: can only be called by an authorized blood supplier
- checkHospital: can only be called by an authorized hospital
- existsHospitalPermission: can only be called if the calling entity is an authorized hospital