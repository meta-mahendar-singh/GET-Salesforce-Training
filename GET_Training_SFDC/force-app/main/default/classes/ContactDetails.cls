public class ContactDetails {
    
    public static String checkContact(ID cntId){
        
        ID accountId = [SELECT Account.ID  FROM Contact WHERE ID =:cntId][0].Account.ID;
        Account acc = [SELECT Name , ContactIds__c FROM Account WHERE ID =: accountId ];
        String cntIds = acc.ContactIds__c;
        if(cntIds == null){
            list<Contact> cts = [SELECT ID FROM Contact WHERE ACCOUNT.ID =: accountId];
            cntIds = cts[0].ID;
            for(Integer i=1;i<cts.size();i++){
                if(i!=cts.size()-1){
                    cntIds+=' , ';
                }
                cntIds = cntIds + cts[i].ID;
            }
        }else{
            if(!cntIds.contains(cntId)){
                cntIds+=cntId;
            }
        }
        acc.ContactIds__c = cntIds;
        update acc;
        return cntIds;
    }
}