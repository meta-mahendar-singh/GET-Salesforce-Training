@isTest
public class TestJSONFormatController {

    @testSetup
    static void setUpTestdata() {
    	Class__c testClass = new Class__c(Name = 'testClass');
        insert testClass;
        Student__c testStudent = new Student__c(lastName__c = 'testStudent', Class__c = testClass.Id);
        insert testStudent;
    }
    
    @isTest
    static void testJSONString() {
        Student__c testStudent = [SELECT Name , Class__c FROM Student__c WHERE lastName__c = 'testStudent'];
        JSONFormatController JSONController = new JSONFormatController(new ApexPages.StandardController(testStudent));
        JSONController.serailize();
        Student__c std = (Student__c)JSON.deserialize(JSONController.JSONObjectString, Student__c.Class);
        System.assert(JSONController.JSONObjectString!=null, 'JSON String not built');
        System.assertEquals(std.Name,testStudent.Name, 'JSON String not built for given object');
    }
}