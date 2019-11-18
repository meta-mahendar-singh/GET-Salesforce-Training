/*
 * utility class for TestOpportunityStage
 */ 
public class TestOpportunityStageUtility {
    
    /*
     * Create opportunity objects
     * @param noOfOpportunity number of opportunities to be created
     */ 
    public static list<Opportunity> createOpportunity(Integer noOfOpportunity){
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < noOfOpportunity ; i++){
            opps.add(new Opportunity(name='test'+i,stageName = 'Prospecting',closeDate = Date.newInstance(2016, 12, 9)));
        }
        insert opps;
        return opps;
    }

    /*
     * update opportunity objects
     * @param opps opportunities to be updated
     */ 
    public static list<Opportunity> UpdateOpportunity(List<Opportunity> opps){
        
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        for(Opportunity op : Opps){
            op.stageName = 'Closed Won';
            oppsToUpdate.add(op);
        }
        return oppsToUpdate;
    }
    
}