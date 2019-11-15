public class OpportunityManage {
    
    public static List<opportunity> AssignManager(List<Opportunity> opps){
        List<Opportunity> updatedOpps = new List<Opportunity>();
        for(Opportunity opp : opps){
            if(opp.BilllToContact__c!=null&&opp.Manager__c==null){
                opp.Manager__c = opp.BilllToContact__r.AccountId;
                updatedOpps.add(opp);
            }
        }
        return updatedOpps;
    }
}