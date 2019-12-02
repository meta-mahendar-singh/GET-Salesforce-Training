@isTest
public class QueryControllerTest 
{
	@isTest
    static void testEmptyQuery() {
        QueryController QCObj = new QueryController();
        QCObj.QueryString = '';
        QCObj.executeThisQuery();
        System.assertEquals(false, QCObj.renderResult, 'Error message  : Query cant be empty');
    }
    
	@isTest
    private static void testNonEmptyInCorrectQuery() {
        QueryController QCObj = new QueryController();
        QCObj.QueryString = 'SELECT Nameee FROM Contact';
        QCObj.executeThisQuery();
        System.assertEquals(false, QCObj.renderResult, 'Error message  : Incorrect Query');
    }
    
    @isTest
    private static void testNonEmptyCorrectQuery() {
        QueryController QCObj = new QueryController();
        QCObj.QueryString = 'SELECT Name FROM Contact';
        QCObj.executeThisQuery();
        System.assertEquals(true, QCObj.renderResult, 'Query Not executed successfully');
    }
}