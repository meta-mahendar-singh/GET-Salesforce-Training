/*
 * utility class to create data for TestHindiTeacher
 */ 
public class TestHindiTeacherUtility {
	/*
	 * Create objects of Teacher
	 * @param noOfTeacher number of teachers to be created
	 * @param subject the teacher teaches
	 */ 
    public static list<Contact> CreateContact(Integer noOfTeacher, String subject){
        
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i<noOfTeacher;i++){
            contacts.add(new Contact(lastName='test'+i, Subject__c = subject ));
        }
        return contacts;
    }
}