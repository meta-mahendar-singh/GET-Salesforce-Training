//Trigger to update MyCount Field 
trigger UpdateMyCountField on Student__c (after insert ,after update) {
 
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