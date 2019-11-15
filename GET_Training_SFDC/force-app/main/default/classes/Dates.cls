public class Dates {
    
    public static Integer noOfWorkingDays(Date d1, Date d2){  
        Date reference = Date.newInstance(1900, 1, 8);
        Integer count1 = 5*(d1.daysBetween(reference)/7) + math.min(5,math.mod(d1.daysBetween(reference),7));
        Integer count2 = 5*(d2.daysBetween(reference)/7) + math.min(5,math.mod(d2.daysBetween(reference),7));
        return (count1-count2);
    }
    
}