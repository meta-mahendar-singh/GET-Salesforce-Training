/*
 * Test class for OpportunityManage class
 */
@isTest
public class TestOpportunityManage {
    /*
     * setup data for test
     */ 
    @testSetup
    static void setUpTestdata(){
        List<opportunity> opportunities = new list<opportunity>();
        for(integer i=0 ; i < 100 ; i++){
            opportunities.add(new Opportunity(name='test'+i,stageName = 'Prospecting',closeDate = Date.newInstance(2016, 12, 9))); 
        }
        insert opportunities;
        List<Account> accounts = new list<Account>();
        for(integer i=0 ; i < 100 ; i++){
            accounts.add(new Account(name = 'testAccount'+i));
        }
        insert accounts;
        Integer index=0;
        List<Contact> contacts = new list<Contact>();
        for(integer i=0 ; i < 100 ; i++){
            contacts.add(new Contact(lastname = 'testContact'+i,AccountId = accounts[index].Id , subject__c = 'English'));
            index++;
        }
        insert contacts;
    }
    
    /*
     * Test if manager field populates on update of opportunity
     */ 
    @isTest
    static void TestManagerField(){
        List<opportunity> opportunities = [SELECT ID , 	BilllToContact__c , Manager__c FROM Opportunity];
        List<Contact> contacts = [SELECT ID , accountId FROM Contact];
        List<opportunity> opportunitiesToUpdate = new list<Opportunity>();
        Integer index=0;
        test.startTest();
        for(opportunity opp : opportunities){
            opp.BilllToContact__c = contacts[index].Id;
           	opportunitiesToUpdate.add(opp);
            index++;
        }
        index=0;
        update opportunities;
        List<opportunity> UpdatedOpportunities = [SELECT ID , 	BilllToContact__c , Manager__c FROM Opportunity];
        test.stopTest();
        for(opportunity opp : UpdatedOpportunities){
            System.assertEquals(contacts[index].accountId, opp.Manager__c);
            index++;
        }
        
    }
}