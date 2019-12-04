@isTest
public class RemoteDeleteStudentControllerTest {
    
    @testSetup
    public static void testDataSetup() {
        Class__c newClass = new Class__c(name = 'test');
        insert newClass;
        List<Student__c> students = new List<Student__c>();
        for(Integer i = 0 ; i < 100 ; i++) {
            students.add(new Student__c(firstName__c = 'first'+i ,lastName__c = 'last'+i ,Class__c = newClass.Id));
        }
        insert students;
    }
    
    @isTest
    public static void testDelete() {
        List<Student__c> students = [Select Id , firstName__c FROM Student__c];
        List<Id> studentIds = new List<Id>();
        for(Integer index = 0 ; index < students.size() ; index++) {
            studentIds.add(students[index].Id);
        }
        database.DeleteResult[] result = RemoteDeleteStudentController.deleteStudents(studentIds);
        for(Integer i = 0 ; i < result.size() ; i++) {
            System.assertEquals(result[i].isSuccess(), true,'Could not delete all or some records');
        }
        RemoteDeleteStudentController controller = new RemoteDeleteStudentController(new ApexPages.StandardSetController(students));
        System.assertEquals(controller.Render, false,'Could not render page content properly');
    }
}