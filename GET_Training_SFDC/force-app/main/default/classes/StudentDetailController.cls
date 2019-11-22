public class StudentDetailController {
    
    private final Student__c std ; 
    
    public StudentDetailController(ApexPages.StandardController std) {
        this.std = (Student__c)std.getRecord();
    }
    
    public PageReference savePdf() {
        system.debug(std.Id);
        PageReference pdf = Page.StudentDetails2;
        pdf.getParameters().put('id',std.Id);
        Attachment attach = new Attachment();
        attach.Body = pdf.getContentAsPDF();
        attach.Name = 'StudentDetails.pdf';
        attach.IsPrivate = false;
        attach.ParentId = std.Id;
        List<Attachment> attachmentList = [SELECT Id, ParentId FROM Attachment WHERE ParentId = :std.Id];
        if(attachmentList.size() > 0) 
        {
            delete attachmentList[0];
        }
        insert attach;
        return new PageReference('/'+std.Id);
    }
    
}