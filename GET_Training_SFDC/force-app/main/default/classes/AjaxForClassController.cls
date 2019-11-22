public class AjaxForClassController {
    
    public Id ClassId{get;set;}
    public boolean Render{get;set;}
    public Class__c SelectedClass{get;set;}
    
    public AjaxForClassController() {
        render = false;
    }
    
    Public list<Class__c> getClasses() {
        List<Class__c> classes = [SELECT Name , ClassTeacher__r.Name , Board__c , Fee__c , MaxSize__c , Custom_Status__c FROM Class__c];
        return classes ;
    }
    
    public void editClass() {
        SelectedClass = [SELECT Name , ClassTeacher__r.Name , Board__c , Fee__c , MaxSize__c , Custom_Status__c FROM Class__c WHERE Id = :ClassId];
        Render = true ;
    }
    
    public void updateClass() {
        update SelectedClass;
        Render = false ;
    }
    
    public void deleteClass() {
        SelectedClass = [SELECT Name , ClassTeacher__r.Name , Board__c , Fee__c , MaxSize__c , Custom_Status__c FROM Class__c WHERE Id = :ClassId];
        Render = false ;
        delete SelectedClass;
    }
}