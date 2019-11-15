public class SchemaObjects {
    
    public List<schema.sObjectType> getAllObjects()
    {
        List<schema.sObjectType> allObjects = Schema.getGlobalDescribe().Values();
        return allObjects;
    }
}