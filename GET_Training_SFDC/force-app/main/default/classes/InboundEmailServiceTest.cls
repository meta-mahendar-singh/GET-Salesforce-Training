@isTest
public class InboundEmailServiceTest {
    
    @isTest
    static void testEmailService() {
        Messaging.InboundEmail inboundEmail = new Messaging.InboundEmail(); 
        inboundEmail.fromAddress = 'mahendar.singh@metacube.com';
        Messaging.InboundEmail.TextAttachment textAttachment = new Messaging.InboundEmail.TextAttachment();
        textAttachment.fileName = 'CreateContacts.XML';
        textAttachment.body = ( '<contacts>'+
                               		'<contact>'+
                                        '<firstname>firstname1</firstname>'+
                                        '<lastname>lastname1</lastname>'+
                                        '<email>email1@gmail.com</email>'+
                                        '<deptartment>department1</deptartment>'+
                                        '<phone>111111</phone>'+
                                   	'</contact>'+
                                    '<contact>'+
                                        '<firstname>firstname2</firstname>'+
                                        '<lastname>lastname2</lastname>'+
                                        '<email>email2@gmail.com</email>'+
                                        '<deptartment>department1</deptartment>'+
                                        '<phone>111111</phone>'+
                                   	'</contact>'+
                               		'<contact>'+
                                        '<firstname>firstname3</firstname>'+
                                        '<lastname>lastname3</lastname>'+
                                        '<email>email3@gmail.com</email>'+
                                        '<deptartment>department1</deptartment>'+
                                        '<phone>111111</phone>'+
                                   	'</contact>'+
                                '</contacts>' );
        inboundEmail.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { textAttachment };
        InboundEmailService emailService = new InboundEmailService();
        test.startTest();
        emailService.handleInboundEmail(inboundEmail,null);
        test.stopTest();
        List<Contact> contacts = [SELECT Id FROM Contact];
        system.assertEquals(3, contacts.size(), 'Email service could not create required contacts');
        
    }
    
}