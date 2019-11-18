/*
 * Utility class to create data for TestClassHavingFemale
 */
public class TestClassHavingFemaleUtility {
    
    /*
     * Create a class along with students
     * @param noOfClass number of classes to be created
     * @param noOfGirls number of girls in each class
     */ 
    public static list<Class__c> CreateClass(Integer noOfClass, Integer noOfGirls){
        
        List<Class__c> classes = new List<Class__c>();
        list<Student__c> students = new list<student__c>();
        for(Integer i = 0 ; i<noOfClass;i++){
            class__c newClass = new Class__c(name='test'+i);
            classes.add(newClass);
        }
        insert classes;
        for(Integer j = 0;j<noOfClass;j++){
            class__c cls= classes[j];
            Integer girls=0;
            for(Integer k = 0; k<20;k++){
                if(girls<noOfGirls){
                    students.add(new Student__c(name='student'+j+k,lastName__c='sur'+j+k,sex__c='Female',class__c=cls.Id));
                    girls++;
                }else{
                    students.add(new Student__c(name='student'+j+k,lastName__c='sur'+j+k,sex__c='Male',class__c=cls.Id));
                }
            }
        }
        insert students;
        return classes;
    }
    
}