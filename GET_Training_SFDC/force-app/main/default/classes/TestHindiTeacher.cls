/*
 * test class for HindiTeacher trigger
 */ 
@isTest
public class TestHindiTeacher {
    
    /*
     * test to insert single teacher with hindi subject
     */
    @isTest
    static void SingleHindiTeacher(){
        list<Contact> contacts = TestHindiTeacherUtility.CreateContact(1,'Hindi');
        test.startTest();
        database.SaveResult result = database.insert(contacts[0],false);
        test.stopTest();
        System.assert(!result.isSuccess());
        System.assertEquals('Can not add or update teacher having hindi subject', result.getErrors()[0].getMessage());        
    }
    /*
     * test to insert single teacher with non hindi subject
     */
    @isTest
    static void SingleNonHindiTeacher(){
        list<Contact> contacts = TestHindiTeacherUtility.CreateContact(1,'english');
        test.startTest();
        database.SaveResult result = database.insert(contacts[0],false);
        test.stopTest();
        System.assert(result.isSuccess());   
    }
    /*
     * test to insert bulk teachers with hindi subject
     */
    @isTest
    static void BulkHindiTeacher(){
        list<Contact> contacts = TestHindiTeacherUtility.CreateContact(200,'Hindi;english');
        test.startTest();
        database.SaveResult[] results = database.insert(contacts,false);
        test.stopTest();
        for(Database.SaveResult result : results){
            System.assert(!result.isSuccess());
            System.assertEquals('Can not add or update teacher having hindi subject', result.getErrors()[0].getMessage()); 
        }
    }
    /*
     * test to insert bulk teachers with non hindi subject
     */
    @isTest
    static void BulkNonHindiTeacher(){
        list<Contact> contacts = TestHindiTeacherUtility.CreateContact(200,'English');
        test.startTest();
        database.SaveResult[] results = database.insert(contacts,false);
        test.stopTest();
        for(Database.SaveResult result : results){
            System.assert(result.isSuccess());
        }       
    }
}