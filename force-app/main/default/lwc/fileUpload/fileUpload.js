import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import uploadFile from '@salesforce/apex/FileUploaderClass.uploadFilebyReference';

export default class FileUpload extends LightningElement {

    fileData;
    accept = ['jpg','png','pdf'];
    fileOptions = [{label:'PDF', value: 'pdf'},
                    {label:'JPG',value:'jpg'},
                    {label:'PNG',value:'png'}];
    loading = false;

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
        const {base64, filename} = this.fileData;
        uploadFile({ base64, filename}).then(result=>{
            this.fileData = null;
            if(result.includes('Invalid')){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: `Error uploading file - Max Size is 2mb`,
                        variant: 'error'
                    }),
                );
            } else {
                console.log(result);
                let title = `${filename} uploaded successfully!!`;
                this.toast(title);
            }
        });
    }

    toast(title){
        const toastEvent = new ShowToastEvent({
            title,
            variant:'success'
        });
        this.dispatchEvent(toastEvent);
    }

    imagePreview(e) {
        const blob = new Blob([e], { type: 'application/pdf' });
        const blobURL = URL.createObjectURL(blob);
        this.pic = blobURL;
    }
    
}