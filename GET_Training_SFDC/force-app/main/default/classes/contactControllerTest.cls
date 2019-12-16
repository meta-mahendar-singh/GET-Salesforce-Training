@isTest
public class contactControllerTest {
	
    @isTest
    static void testSaveContact() {
        Contact con = new Contact(FirstName = 'Naman' , LastName = 'Sinha' ,Email = 'naman@nm.com',Phone = '1234567890'  , Fax = '12-123-1234567');
        contactController.saveContact(con);
        Contact savedContact = [SELECT Id FROM Contact WHERE Email = 'naman@nm.com' LIMIT 1];
        System.assertEquals(con.Id, savedContact.Id,'Contact could not be saved');
     }
    
    @isTest
    static void testSaveInvalidContact() {
        Contact con = new Contact(FirstName = 'Naman' , LastName = 'Sinha' ,Email = 'naman@nm',Phone = '1234567890'  , Fax = '12-123-1234567');
        try{
        contactController.saveContact(con);
        }catch(DMLException ex){
            
        }
        System.assertEquals(con.Id, null,'Contact saved');
     }
    
}