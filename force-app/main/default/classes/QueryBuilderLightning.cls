public with sharing class QueryBuilderLightning {
    @AuraEnabled
    public static List<String> getObjectName() {
      List<String> objects = new List<String>();
      List<Schema.SObjectType> sObjectList = Schema.getGlobalDescribe().Values();
      for (SObjectType sObjectType : sObjectList) {
        objects.add(sObjectType.getDescribe().getName());
      }
      objects.sort();
      // System.debug(objects);
      return objects;
    }
    @AuraEnabled
    public static List<String> getFields(String sObjectAPIName) {
      List<String> response = new List<String>();
      List<String> fieldNames = new List<String>();
      String object_API_Name = sObjectAPIName;
      Map<String, Schema.SObjectField> M_Objects_Schema_Field = Schema.getGlobalDescribe()
        .get(object_API_Name)
        .getDescribe()
        .fields.getMap();
      for (String fieldName : M_Objects_Schema_Field.keySet()) {
        Schema.DescribeFieldResult fieldDescription = M_Objects_Schema_Field.get(
            fieldName
          )
          .getDescribe();
        fieldNames.add(fieldDescription.getName());
      }
      return fieldNames;
    }
    @AuraEnabled
    public static List<List<String>> getQueryResults(
      String query,
      List<String> selectedValues
    ) {
      List<List<String>> response = new List<List<String>>();
      List<sObject> queryResult = Database.query(query);
      for (sObject i : queryResult) {
        List<String> sObjectFieldValues = new List<String>();
        for (String j : selectedValues) {
          sObjectFieldValues.add(String.valueof(i.get(j)));
        }
        response.add(sObjectFieldValues);
      }
      return response;
    }
  }