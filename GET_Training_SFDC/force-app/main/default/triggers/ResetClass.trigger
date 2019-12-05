//Trigger to delete all associated students with Class value is “Reset” 
trigger ResetClass on Class__c (after update) {
    
    List<Student__c> students = new list<Student__c>();
    for(Student__c st : [SELECT Name , class__c FROM Student__c WHERE class__c IN :Trigger.New AND Class__r.Custom_Status__c = 'Reset']){
        if((Trigger.oldMap.get(st.class__c)).Custom_Status__c != 'Reset' ){
            students.add(st);
        }
    }
    delete students;
}