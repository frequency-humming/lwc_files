public with sharing class ViewPdfController  {
    
    public String pdf {get;set;}
    public Boolean notyet {get;set;}
    public String pdffile {get;set;}
    
    public void setpdf(String base64){
        Blob file_body = EncodingUtil.base64Decode(base64);
        pdf = EncodingUtil.Base64Encode(file_body);
    }
    
    public static void inputfile(String base64){
        Blob file_body = EncodingUtil.base64Decode(base64);
        //pdffile = EncodingUtil.Base64Encode(file_body);
        system.debug('in input file');
    }
    
    public String getpdffile() {
        return 'data:application/pdf;base64,'+EncodingUtil.base64Encode([SELECT VersionData FROM ContentVersion WHERE ID = '0698c00000AYK9mAAH'].VersionData);
    }
    
    public void setnotyet(boolean bool){
        notyet = bool;
    }
    
        
    public String getpdf() {
    	return pdf;
    }
    
    public boolean getnotyet(){
        return notyet;
    }
    public void yet(){
        notyet = true;
    }

}