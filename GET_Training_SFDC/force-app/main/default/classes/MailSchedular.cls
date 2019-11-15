global class MailSchedular implements Schedulable {
    
    global void execute(SchedulableContext ctx){
        List<opportunity> opportunities = [SELECT ID,Owner.Email FROM Opportunity WHERE LastModifiedDate = LAST_N_DAYS:30]; 
        System.debug(opportunities.size());
        for(Opportunity opp : opportunities){
            System.debug('Hello' + opp.ID);
        } 
    }
}