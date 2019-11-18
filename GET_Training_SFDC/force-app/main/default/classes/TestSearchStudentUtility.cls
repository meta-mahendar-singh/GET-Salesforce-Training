/*
* Utility class to create data for TestSearchStudent test class
*/
public class TestSearchStudentUtility {
    
    /*
    * Create a class with students object
    * @param noOfClasses number of classes to be created
    * @param noOfStudents number of students to be added to class
    */ 
    public static List<Class__c> createClass(Integer noOfClasses, Integer noOfStudents){
        
        List<Class__c> classes = new List<Class__c>();
        list<Student__c> students = new list<student__c>();
        for(Integer i = 0 ; i<noOfClasses;i++){
            class__c newClass = new Class__c(name='test'+i);
            classes.add(newClass);
        }
        insert classes;
        for(Integer j = 0;j<noOfClasses;j++){
            class__c cls= classes[j];
            for(Integer k = 0; k<noOfStudents;k++){
                students.add(new Student__c(name='student'+j+k,lastName__c='sur'+j+k,class__c=cls.Id));
            }
        }
        insert students;
        return classes;   
    }
}