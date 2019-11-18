//Trigger to not Allow any teacher to insert/update if that teacher is teaching Hindi
trigger HindiTeacher on Contact (before insert, before update) {
    
    for(Contact teacher : Trigger.New){
        if(teacher.Subject__c.contains('Hindi')){
            teacher.addError('Can not add or update teacher having hindi subject');
        }
    }
}