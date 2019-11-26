@isTest
public class TestAjaxForClassController {

    @testSetup
    static void setUpTestdata() {
    	Class__c testClass = new Class__c(Name = 'testClass');
        insert testClass;
    }
    
    @isTest
    static void testUpdateClass() {
        AjaxForClassController controller = new AjaxForClassController();
        // call getClass method
        list<Class__c> allClasses = controller.getClasses();
        controller.ClassId = allClasses[0].Id;
        //call editClass method
        controller.editClass();
        controller.SelectedClass.Name = 'test1';
        controller.SelectedClass.Board__c = 'RAJ';
        controller.SelectedClass.Fee__c = 10000;
        controller.SelectedClass.MaxSize__c = 40;
        //call updateClassMethod
        controller.updateClass();
        allClasses = controller.getClasses();
        System.assertEquals(10000, allClasses[0].Fee__c,'Class not updated');
    }
    
    @isTest
    static void testDeleteClass() {
        AjaxForClassController controller = new AjaxForClassController();
        list<Class__c> allClasses = controller.getClasses();
        controller.ClassId = allClasses[0].Id;
        controller.deleteClass();
        allClasses = controller.getClasses();
        System.assertEquals(0, allClasses.size(),'Class not deleted');
    }
}