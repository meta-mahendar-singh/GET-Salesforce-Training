trigger OpportunityManageTrigger on Opportunity (after update) {
    
    List<Opportunity> opps = [SELECT Name, BilllToContact__c,BilllToContact__r.AccountID,Manager__c FROM Opportunity WHERE Id IN :Trigger.New];
    update OpportunityManage.AssignManager(opps);
    
}