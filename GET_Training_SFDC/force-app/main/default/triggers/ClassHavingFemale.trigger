//Trigger to not allow any class to delete if there are more than one Female students.
trigger ClassHavingFemale on Class__c (before delete) {
    
    List<AggregateResult> classes = [SELECT Class__c FROM Student__c WHERE Sex__c = 'Female' GROUP BY class__c HAVING COUNT(name) > 1];
    List<Id> classIds = new List<Id>();
    for(AggregateResult a: classes){
        if(Trigger.oldMap.keyset().contains((ID)(a.get('class__c')))){
            classIds.add((ID)(a.get('class__c')));
        }
    }
    for(Id classId : classIds){
        Trigger.oldMap.get(classId).addError('Cant delete class having more than 1 Female Students');
    }
    
}