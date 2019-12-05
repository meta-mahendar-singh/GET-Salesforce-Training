//Trigger to not allow insert student if class already reached MaxLimit and update myCount Field of related class after insert/update
trigger StudentLimitAndCountField on Student__c (before insert,after insert ,after update) {
    
    if(Trigger.isBefore){
        Set<ID> classIds = new Set<ID>();
        for(Integer i = 0; i < Trigger.new.Size(); i++)
        {
            classIds.add(Trigger.new[i].class__c);
        }
        Map<Id,Class__c> classes = new Map<Id,Class__c>([Select Name, NumberOfStudents__c ,MaxSize__c FROM Class__c WHERE ID In :classIds]);
        for(Student__c st : Trigger.New){
            if(classes.get(st.class__c).NumberOfStudents__c == classes.get(st.class__c).MaxSize__c){
                st.addError('class size already full');
            }
        }
    }else{
        List<Class__c> classToUpdate = new List<Class__c>();
        List<Id> oldClasses = new List<Id>();
        List<Id> newClasses = new List<Id>();
        
        for(Student__c st : Trigger.new){
            newClasses.add(Trigger.newMap.get(st.Id).class__c);
            if(Trigger.isUpdate){
                oldClasses.add(Trigger.oldMap.get(st.Id).class__c);
            }
        }
        List<Class__c> classes = [SELECT (SELECT Name FROM Students__r) FROM Class__c WHERE Id In :newClasses OR Id IN :oldClasses ];
        for(Class__c cl : classes ){
            cl.MyCount__c = cl.Students__r.size();
            classToUpdate.add(cl);
        }
        update classToUpdate;
    }
    
}