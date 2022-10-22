import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import uploadFile from '@salesforce/apex/FileUploaderClass.uploadFilebyReference';
import sendFile from '@salesforce/apex/FileUploaderClass.sendFilebyReference';

export default class FileUpload extends LightningElement {

    fileData;
    accept = ['jpg','png','pdf'];
    fileOptions = [{label:'PDF', value: 'pdf'},
                    {label:'JPG',value:'jpg'},
                    {label:'PNG',value:'png'}];
    loading = false;
    filename;
    path;
    temp = ' ';

    openfileUpload(event) {
        const file = event.target.files[0];
        const ext = file.name.split('.')[1];
        if(this.accept.includes(ext)){
            var reader = new FileReader();
            reader.readAsDataURL(file);
            reader.onload = () => {
                var base64 = reader.result.split(',')[1];
                this.fileData = {
                    'filename': file.name,
                    'base64': base64
                }
                this.template.querySelector('h2').className='temp';
                this.temp = file.name;
            }
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: `File type not supported`,
                    variant: 'error'
                }),
            );
        }
           
    }
    
    handleClick(){
        this.loading = true;
        const {base64, filename} = this.fileData;
        uploadFile({ base64, filename}).then(result=>{
            this.fileData = null;
            if(result.includes('Invalid')){
                this.parseResponse('Error saving the file');
            } else {
                let data = result.split(',');
                this.path = data[0];
                this.filename = data[1];
                sendFile({url:this.path,filename:this.filename}).then(result => {
                    if(result.includes('Invalid')){
                        this.parseResponse(result);
                    }else{
                        this.loading = false;
                        let title = `${filename} uploaded successfully!!`;
                        this.toast(title);
                        this.temp = null;
                    }
                });       
            }
        });
    }

    parseResponse(result){
        this.loading = false;
        this.temp = null;
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: `Error uploading file - ${result}`,
                variant: 'error'
            }),
        );
    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title,
            variant:'success'
        });
        this.dispatchEvent(toastEvent);
    }
    
}