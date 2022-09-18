public with sharing class FileUploaderClass {

  @AuraEnabled
  public static String uploadFile(String base64, String filename) {
    String res = uploadRequest(base64, filename);
    if (res == null) { return null; }
      return res;
   }

  @AuraEnabled
  public static String retrieveFile(String filename) {
    system.debug('in the apex class'+filename);
    String res = retrieveRequest(filename);
    if (res == null) { return null; }
      return res;
   }

  private static String uploadRequest(String base64, String filename) {
    String response = FileRequest.postRequest(base64,filename);
    return response;
  }

  private static String retrieveRequest(String filename){
    system.debug('in the apex class'+filename);
    String response = FileRequest.makeRequest(filename);
    return response;
  }
}