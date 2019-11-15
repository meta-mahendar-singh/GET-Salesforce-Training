@IsTest(SeeAllData=true)
public class MailSchedularTest {
    @IsTest
    public static void mailTest(){
        Test.startTest();
        MailSchedular ml = new MailSchedular();
        String jobId = System.Schedule('mail test' , '0 0 * * * ?',ml);
        Test.stopTest();
    }
}