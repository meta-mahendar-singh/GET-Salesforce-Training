/*
 * Test class for ContactDetails Class
 */
@isTest
public class TestContactDetails {
    
    /*
     * data setup for test
     */
    @testSetUp
    static void setupTestData(){
        
        Account testAccount = new Account(name = 'testAccount');
        insert testAccount;
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0 ; i < 3 ; i++){
            contacts.add(new Contact(lastName = 'testContact' + i , AccountId = testAccount.Id , Subject__c = 'English'));
        }
        insert contacts;
        
    }
    
    /*
     * test When ContactIds Field is null
	*/
    @isTest
    static void ContactIdsNull(){
        Account testAccount = [SELECT Id , ContactIds__c FROM ACCOUNT WHERE name = 'testAccount'];
        List<Contact> contacts = [SELECT ID FROM Contact WHERE AccountId = :testAccount.Id];
        test.startTest();
        String ContactIds = ContactDetails.checkContact(contacts[0].Id);
        test.stopTest();
        String contactIdsFromDB ;
        contactIdsFromDB = contacts[0].ID;
        for(Integer i=1;i<contacts.size();i++){
            if(i!=contacts.size()-1){
                contactIdsFromDB+=' , ';
            }
            contactIdsFromDB = contactIdsFromDB + contacts[i].ID;
        }
        System.assertEquals(ContactIds,ContactIdsFromDB);
    }
    
    /*
     * test When ContactIds Field is not null
     */
    @isTest
    static void ContactIdsNotNull(){
        Account testAccount = [SELECT Id , ContactIds__c FROM ACCOUNT WHERE name = 'testAccount'];
        List<Contact> contacts = [SELECT ID FROM Contact WHERE AccountId = :testAccount.Id];
        testAccount.ContactIds__c = contacts[0].Id;
        update testAccount;
        test.startTest();
        String ContactIds = ContactDetails.checkContact(contacts[0].Id);
        test.stopTest();
        System.assertEquals(ContactIds,contacts[0].Id);
    }
}