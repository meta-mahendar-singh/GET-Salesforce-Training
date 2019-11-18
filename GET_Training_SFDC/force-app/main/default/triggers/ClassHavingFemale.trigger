//Trigger to not allow any class to delete if there are more than one Female students.
trigger ClassHavingFemale on Class__c (before delete) {
    
    List<AggregateResult> classes = [SELECT Class__c FROM Student__c WHERE Sex__c = 'Female' GROUP BY class__c HAVING COUNT(name) > 1];
    List<Id> classIds = new List<Id>();
    for(AggregateResult a: classes){
        classIds.add((ID)(a.get('class__c')));
    }
    for(Class__c c : [Select Id FROM class__c WHERE Id IN :Trigger.old AND Id IN :classIds]){
        Trigger.oldMap.get(c.Id).addError('Cant delete class having more than 1 Female Students');
    }
    
}