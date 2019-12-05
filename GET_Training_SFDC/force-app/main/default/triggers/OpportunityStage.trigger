trigger OpportunityStage on Opportunity (before update , after update) {
    
    if(Trigger.isBefore){
        
        for(opportunity op : Trigger.New ){
            if((Trigger.oldMap.get(op.Id).StageName != op.StageName) && (op.StageName == 'Closed Won' || op.StageName == 'Closed Lost')){
                op.CloseDate = date.today();
                system.debug(op.CloseDate);
            }
        }
    }
    if(Trigger.isAfter){ 
        List<opportunity> mailList = new List<Opportunity>();
        for(opportunity op : [SELECT Id , stageName ,ownerId, owner.email, CloseDate FROM Opportunity WHERE Id IN :Trigger.New ]){
            if(Trigger.oldMap.get(op.Id).StageName != op.StageName){
                mailList.add(op);
            }
        }
        MailOnOpportunityStage.sendEmail(mailList); 
    }
}