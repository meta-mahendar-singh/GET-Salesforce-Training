@isTest
public class TestCustomLookUpController {
    
    @testSetup
    static void setUpTestdata() {
        Account acc = new Account(Name = 'testAccount');
        insert acc;
        Contact con = new Contact(LastName = 'testContact', AccountId = acc.Id ,Subject__c = 'English');
        insert con;
        Opportunity opp = new Opportunity(Name = 'testOpportunity', Manager__c = acc.Id,BilllToContact__c = null,StageName = 'Prospecting', CloseDate = System.today());
        insert Opp;
    }
    
    @isTest
    static void testGetContactOptions() {
        PageReference pageRef = Page.CustomLookUp;
        Opportunity opp = [SELECT Name , Manager__c ,BilllToContact__c ,StageName , CloseDate FROM Opportunity WHERE NAME = 'testOpportunity'];
        Contact con = [SELECT Name , AccountId FROM Contact WHERE lastName = 'testContact'];
        pageRef.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pageRef);
        CustomLookUpController lookUpController = new CustomLookUpController();
        lookUpController.CurrentOpportunityId = opp.Id;
        lookUpController.SelectedContact = con.Id;
        List<Contact> ContactObjects = new List<Contact>();
        ContactObjects.add(con);
        list<SelectOption> options = new list<SelectOption>();
        for(Contact currentContact : ContactObjects){
            options.add(new SelectOption(currentContact.Id,currentContact.Name));
        }
        System.assertEquals(lookUpController.getContactOptions(), options, 'Not all contact options displayed');
    }
    
    @isTest
    static void testSaveContact() {
        PageReference pageRef = Page.CustomLookUp;
        Opportunity opp = [SELECT Name , Manager__c ,BilllToContact__c ,StageName , CloseDate FROM Opportunity WHERE NAME = 'testOpportunity'];
        Contact con = [SELECT LastName , AccountId FROM Contact WHERE lastName = 'testContact'];
        pageRef.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pageRef);
        CustomLookUpController lookUpController = new CustomLookUpController();
        lookUpController.CurrentOpportunityId = opp.Id;
        lookUpController.SelectedContact = con.Id;
        pageRef = lookUpController.saveContact();
        System.assertEquals(pageRef.getUrl(), '/'+opp.Id, 'Page was not redirected as expected.');
        System.assertEquals(con.Id, [SELECT BilllToContact__c FROM Opportunity WHERE Id =: opp.Id][0].BilllToContact__c, 'BillTOContact__c field was not populated as Expected.');
    }
    
    @isTest
    private static void testClearContact() {	
        PageReference pageRef = Page.CustomLookUp;
        Opportunity opp = [SELECT Name , Manager__c ,BilllToContact__c ,StageName , CloseDate FROM Opportunity WHERE NAME = 'testOpportunity'];
        Contact con = [SELECT LastName , AccountId FROM Contact WHERE lastName = 'testContact'];
        pageRef.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pageRef);
        CustomLookUpController lookUpController = new CustomLookUpController();
        lookUpController.CurrentOpportunityId = opp.Id;
        lookUpController.SelectedContact = con.Id;
        pageRef = lookUpController.saveContact();
        pageRef = lookUpController.clearContact();
        System.assertEquals(pageRef.getUrl(), '/'+opp.Id, 'Page was not redirected as expected.');
        System.assertEquals(null, [SELECT BilllToContact__c FROM Opportunity WHERE Id =: opp.Id][0].BilllToContact__c, 'BillTOContact__c field was not cleared.');
    }
    
    @isTest
    private static void testCancel() {	
        PageReference pageRef = Page.CustomLookUp;
        Opportunity opp = [SELECT Name , Manager__c ,BilllToContact__c ,StageName , CloseDate FROM Opportunity WHERE NAME = 'testOpportunity'];
        pageRef.getParameters().put('Id', opp.Id);
        Test.setCurrentPage(pageRef);
        CustomLookUpController lookUpController = new CustomLookUpController();
        pageRef = lookUpController.cancel();
        System.assertEquals(pageRef.getUrl(), '/'+opp.Id, 'Page was not redirected as expected.');
    }
    
}