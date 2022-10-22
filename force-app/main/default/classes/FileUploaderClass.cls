public with sharing class FileUploaderClass {

  @AuraEnabled
  public static String uploadFile(String base64, String filename) {
    String res = uploadRequest(base64, filename);
    if (res == null) { return null; }
      return res;
   }

  @AuraEnabled
  public static String retrieveFile(String filename) {
    String res = retrieveRequest(filename);
    if (res == null) { return null; }
      return res;
   }
  @AuraEnabled
  public static String uploadFilebyReference(String base64, String filename) {
    ID contentId;
    Blob decoded = EncodingUtil.base64Decode(base64);
    ContentVersion cv = new ContentVersion();
    try {  
        cv.VersionData = decoded;
        cv.Title = filename;
        cv.PathOnClient = fileName;
        insert cv;
        contentId = cv.Id;
    } catch(DmlException e) {
        System.debug('The following exception has occurred: ' + e.getMessage());
        return 'Invalid File Request';
    }
    if(contentId!=null){
        String Path = '/services/data/v56.0/sobjects/ContentVersion/'+contentId+'/VersionData,';
        system.debug('path '+Path); 
        return path+filename;
    }else{
          return 'Invalid File Request';
    }
  }
  @AuraEnabled
  public static String sendFilebyReference(String url,String filename){
    system.debug('in the last method');
  	String res = FileRequest.sendFileRequest(url,filename);
    return res;
  }

  private static String uploadRequest(String base64, String filename) {
    String response = FileRequest.postRequest(base64,filename);
    return response;
  }

  private static String retrieveRequest(String filename){
    String response = FileRequest.makeRequest(filename);
     System.debug(response);
    if(String.isBlank(response) || response.contains('Invalid')){
    	return 'Invalid File';
    }
    String DocId = [SELECT ContentDocumentId from ContentVersion WHERE ID = :response].ContentDocumentId;
    return DocId;
  }
}