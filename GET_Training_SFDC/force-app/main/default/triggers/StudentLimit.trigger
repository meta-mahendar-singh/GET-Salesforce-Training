//Trigger to not allow insert student if class already reached MaxLimit
trigger StudentLimit on Student__c (before insert) {
 
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

}