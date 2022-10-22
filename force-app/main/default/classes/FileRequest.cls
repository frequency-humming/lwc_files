public with sharing class FileRequest {

    public static String makeRequest(String fileName){
        String path = '/testing';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:nodejsapi'+path);
  		request.setBody('name='+fileName);
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setHeader('x-api-key','california');
        HttpResponse response = http.send(request);
        System.debug('request: '+response.getBody());
        // Parse the JSON response
        if(response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
            return response.getBody();
        } else {
            //String foo = response.getBody();
            //Blob decoded = EncodingUtil.base64Decode(foo);
            Blob decoded = response.getBodyAsBlob();
            ContentVersion cv = new ContentVersion();
            cv.VersionData = decoded;
            cv.Title = fileName;
            cv.PathOnClient = fileName;
            insert cv;
            ID contentId = cv.Id;
            return contentId;
        }
    }
        
    public static String postRequest(String base64,String name){
          String endpoint = 'https://nodjs-files.onrender.com/test';
          Blob file_body = EncodingUtil.base64Decode(base64);
          String file_name = name;
          String boundary = '----------------------------741e90d31eff';
          String header = '--'+boundary+'\r\nContent-Disposition: form-data; name="upload"; filename="'+file_name+'"\r\nContent-Type: application/octet-stream';
          String footer = '\r\n--'+boundary+'--';              
          String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
          while(headerEncoded.endsWith('='))
          {
           header+=' ';
           headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
          }
          String bodyEncoded = EncodingUtil.base64Encode(file_body);
          String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));

          Blob bodyBlob = null;
          String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
          if(last4Bytes.endsWith('='))
          {
               Blob decoded4Bytes = EncodingUtil.base64Decode(last4Bytes);
               HttpRequest tmp = new HttpRequest();
               tmp.setBodyAsBlob(decoded4Bytes);
               String last4BytesFooter = tmp.getBody()+footer;   
               bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded.substring(0,bodyEncoded.length()-4)+EncodingUtil.base64Encode(Blob.valueOf(last4BytesFooter)));
          }
          else
          {
                bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
          }

          HttpRequest req = new HttpRequest();
          req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
          req.setHeader('x-api-key','california');
          req.setMethod('POST');
          req.setEndpoint(endpoint);
          req.setBodyAsBlob(bodyBlob);
          req.setTimeout(120000);

          Http http = new Http();
          HTTPResponse res = http.send(req);
         if(res.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + res.getStatusCode() + ' ' + res.getStatus());
            return res.getStatus();
        } else {
            System.debug(res.getBody());
            return res.getBody();
        }
    }
    public static String sendFileRequest(String url,String fileName){
        String path = '/testingpattern';
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:nodejsapi'+path);
  		request.setBody('filename='+fileName+'&url='+url);
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
        request.setHeader('x-api-key','california');
        HttpResponse response = http.send(request);
        System.debug('request: '+response.getBody());
        // Parse the JSON response
        if(response.getStatusCode() != 200) {
            System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getStatus());
            return response.getBody();
        } else {
            system.debug('in the else condition');
            return 'Completed';
        }
    }
}