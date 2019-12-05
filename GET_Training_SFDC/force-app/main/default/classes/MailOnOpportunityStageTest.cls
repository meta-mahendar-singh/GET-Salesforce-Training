@isTest
public class MailOnOpportunityStageTest {

    @testSetup
    public static void setupTestData() {
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < 10 ; i++){
            opps.add(new Opportunity(name='test'+i,stageName = 'Prospecting',closeDate = Date.newInstance(2016, 12, 9)));
        }
        insert opps;
    }
    
    @isTest
    public static void testMail() {
        List<Opportunity> opps = [Select name , stagename FROM opportunity];
        for(Opportunity opp : opps){
            opp.stageName = 'Qualification';
        }
        test.startTest();
        update opps;
        Integer invocations = Limits.getEmailInvocations();
        test.stopTest();
        system.assertEquals(1, invocations, 'Mail not sent to all or some owners');
    }
    
}