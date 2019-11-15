public class SearchStudent {
    
    public static list<String> getStudentsFromClass(ID classId){
        
        Student__c[] students = [SELECT Name FROM Student__c WHERE Class__r.ID=:classId]; 
        list<String> listOfNames = new list<String>();
        for(Student__c s : students){
            listOfNames.add(s.name);
        }
        return listOfNames;
    }
    
    public static map<String,Set<String>> getStudentsWithClass(){
        
        list<Class__c> classStudents= [SELECT Name , (SELECT Name FROM Students__r)  FROM Class__c ];
        map<String,Set<String>> mapOfClassStudents = new map<String,Set<String>>();
        for(Class__c c : classStudents){
            Set<String> studentSet = new Set<String>();
            for(Student__c s : c.Students__r){
                studentSet.add(s.name);
            }
            mapOfClassStudents.put(c.Name, studentSet);             
        }
        return mapOfClassStudents;
    }
    
}