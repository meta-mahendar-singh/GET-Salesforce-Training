/*
 * Test class for OpportunityStage class
 */ 
@isTest
public class TestOpportunityStage {
    /*
     * Test closeDate field on bulk opportunity update
     */ 
   	@isTest
    static void UpdateBulkOpportunity(){
        List<Opportunity> opps = TestOpportunityStageUtility.createOpportunity(100);
        opps = TestOpportunityStageUtility.UpdateOpportunity(opps);
        update opps;
        List<Opportunity> updatedOpps = [Select CloseDate FROM Opportunity WHERE Id IN :opps];
        for(Opportunity op : updatedOpps){
        	System.assertEquals(date.today(),op.closeDate);
        }
        
    }
}