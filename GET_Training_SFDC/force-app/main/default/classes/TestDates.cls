/*
 * test class for Dates class
 */
@isTest
public class TestDates {
    
    @isTest
    static void testOne(){
        Date d1 = date.newInstance(2018, 11, 18);
        Date d2 = date.newInstance(2019, 11, 18);
        System.assertEquals(dates.noOfWorkingDays(d1, d2),259);
    }
    
    @isTest
    static void testTwo(){
        Date d1 = date.newInstance(2010, 01, 18);
        Date d2 = date.newInstance(2019, 11, 18);
        System.assertEquals(dates.noOfWorkingDays(d1, d2),2565);
    }
}