@isTest
public class QueryResultControllerTest {
   
    @testSetup
    static void testDataSetup()
    {
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 1; i < 150; i++)
        {
            contacts.add(new Contact(lastName='test' + i , subject__c = 'English'));
        }
        insert contacts;
    }
    
    @isTest
    static void testGetRecordType() {        
        QueryResultController RCObject = new QueryResultController();
        QueryController QCObject = new QueryController();
        QCObject.QueryString = 'SELECT Name FROM Contact' ;       
        RCObject.setQueryToExecute(QCObject.QueryString);
        System.assertEquals(RCObject.getRecordType(),[SELECT Name FROM Contact LIMIT 5], 'Unexpected records retrieved');
        System.assertEquals(RCObject.lstFields.size(), 2, 'Not all fields of query are retrieved');                
    }
    
    @isTest
    static void testSortData() {
        QueryResultController RCObject = new QueryResultController();
        RCObject.setQueryToExecute('SELECT Name FROM Contact');
        RCObject.fieldName = 'Name' ;
        RCObject.sortData() ;
        System.assertEquals(RCObject.getRecordType(),[SELECT Name FROM Contact ORDER BY Name LIMIT 5], 'records not sorted as expected');
    }
    
    @isTest
    static void testSortDataOnOrderedQuery() {
        QueryResultController RCObject = new QueryResultController();
        RCObject.setQueryToExecute('SELECT Name FROM Contact Order by Name');
        RCObject.fieldName = 'Id' ;
        RCObject.sortData() ;
        System.assertEquals(RCObject.getRecordType(),[SELECT Name FROM Contact ORDER BY Id LIMIT 5], 'records not sorted as epected');
    }
 
}