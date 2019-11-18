/*
 * Utility class to create data for TestUpdateMyCountField
 */ 
public class TestUpdateMyCountFieldUtility {
    
    /*
     * create a class and related students
     * @param noOfStudents number of students in class
     */ 
     public static list<Student__c> CreateStudents(Integer noOfStudents){
        
        Class__c cls = new Class__c(name = 'testClass');
        insert cls;
        list<Student__c> students = new list<student__c>();
        for(Integer j = 0;j<noOfStudents;j++){
            students.add(new Student__c(name='student'+j,lastName__c = 'sur'+j,class__c = cls.Id));
        }
        return Students;
    }
}