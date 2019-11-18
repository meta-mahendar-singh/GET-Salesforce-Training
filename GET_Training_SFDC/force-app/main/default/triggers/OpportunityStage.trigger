// Trigger In Opportunity, If the stage is changed from another value to CLOSED_WON or CLOSED_LOST, populates the Close Date field with Today().
trigger OpportunityStage on Opportunity (after update) {
    
    List<opportunity> updatedOpps = new List<Opportunity>();
    
    for(opportunity op : [SELECT Id , stageName , CloseDate FROM Opportunity WHERE Id IN :Trigger.New AND (StageName = 'Closed Won' OR StageName = 'Closed Lost')]){
        if(Trigger.oldMap.get(op.Id).StageName != op.StageName){
            op.CloseDate = date.today();
            updatedOpps.add(op);
        }
    }
    update updatedOpps;
}