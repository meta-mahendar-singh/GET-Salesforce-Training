public class QueryResultController {
    
    public String QueryToExecute;
    public String finalQuery ;
    public List<string> lstFields {get;private set;}
    public Integer StartingPageRecord{get;set;}
    public Integer EndingPageRecord{get;set;}
    public String fieldName{get;set;}
    
    public QueryResultController() {
        QueryToExecute = '';
        finalQuery = '';
        setCon = null ;
    }
    
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.query(finalQuery));
                system.debug('hello');
                setCon.setPageSize(5);
            }
            return setCon;
        }
        set;
    }
    
    public String getQueryToExecute() {
        return this.queryToExecute;
    }
    
    public void setQueryToExecute(String QueryString) {
        if(!this.QueryToExecute.equalsIgnoreCase(QueryString)) {
            this.QueryToExecute = QueryString;
            this.setCon = null;
            finalQuery = QueryToExecute;
        } 
    }
    
    public List<Sobject> getRecordType() {
        
        List<Sobject> QueryResult = setCon.getRecords();
        startingPageRecord = setCon.getPageNumber() * setCon.getPageSize() - (setCon.getPageSize() - 1);
        EndingPageRecord = setCon.getPageNumber() * setCon.getPageSize() ;
        Set<string> setFields = new Set<String>();
        for(integer i = 0 ; i < QueryResult.size() ; i++){
            setFields.addAll(QueryResult[i].getPopulatedFieldsAsMap().keySet());
        }
        lstFields = new List<String>();
        lstFields.addAll(setFields); 
        return QueryResult;
    }
    
    public void sortData() {
        
        if(finalQuery.containsIgnoreCase('ORDER BY')) {
            finalQuery = finalQuery.substring(0, finalQuery.indexOfIgnoreCase('order by') - 1);
        }
        finalQuery = finalQuery + ' ORDER BY ' + this.fieldName;  
        setCon = null;
    }
    
}