/*
 * test class for SearchStudent class
 */
@isTest
public class TestSearchStudent {
    /*
     * tests getStudentsFromClass method
     */ 
    @isTest
    static void testGetStudentsFromClass(){
        Class__c newClass = TestSearchStudentUtility.createClass(1,100)[0];
        test.startTest();
        List<String> students= SearchStudent.getStudentsFromClass(newClass.Id);
        Integer noOfStudents = students.size();
        test.stopTest();
        System.assertEquals(noOfStudents,100);
    }
    /*
     * tests getStudentsWithClass method
     */ 
    @isTest
    static void testGetStudentsWithClass(){
        List<Class__c> newClasses = TestSearchStudentUtility.createClass(5,100);
        test.startTest();
        Map<String,Set<String>> studentsWithClass= SearchStudent.getStudentsWithClass();
        test.stopTest();
        System.assertEquals(studentsWithClass.size(),5);
    }
}