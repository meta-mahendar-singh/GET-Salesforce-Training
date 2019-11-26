@isTest
public class TestStudentDetailController {
    
    @testSetup
    static void setUpTestdata() {
    	Class__c testClass = new Class__c(Name = 'testClass');
        insert testClass;
        Student__c testStudent = new Student__c(lastName__c = 'testStudent', Class__c = testClass.Id);
        insert testStudent;
    }
    
    @isTest
    static void testSavePdf() {
        Student__c testStudent = [SELECT Name , Class__c FROM Student__c WHERE lastName__c = 'testStudent'];
        StudentDetailController stdController = new StudentDetailController(new ApexPages.StandardController(testStudent));
        stdController.savePdf();
        ID currentPdf = [SELECT Id FROM Attachment WHERE parentId = :testStudent.Id ][0].Id;
        stdController.savePdf();
        list<Attachment> attachments = [SELECT Id FROM Attachment WHERE isDeleted = true AND parentId = :testStudent.Id ALL ROWS];
        System.assertEquals(1,[SELECT COUNT() FROM Attachment WHERE ParentId =: testStudent.Id], 'Attachment was not Created as expected');
        System.assertEquals(currentPdf, attachments[attachments.size() - 1].Id,'PDF was not replaced');
    }
}