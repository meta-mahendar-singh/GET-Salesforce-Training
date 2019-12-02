public class QueryController {
    
    public String QueryString{get;set;}
    public boolean renderResult{get;set;}
    
    public QueryController() {
        renderResult = false ;
    }
    
    public void executeThisQuery() {
        if(String.isBlank(QueryString)) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Query can not be empty'));
            return;
        }else {
            try {
                Database.query(QueryString);
            }catch(QueryException ex) {
                ApexPages.addMessages(ex);
                return;
            }
            
        }
        renderResult = true;
    }
}