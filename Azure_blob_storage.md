# [Azure blob storage](/README.md)

## Steps
- Creates resources
- Get storage account
    + Create a storage account by clicking on creates
    + Select source group
    + Give storage  name 
    + Choose redundancy as LSR
    + Click Continue to create
- After, then move to the next steps
    + Click go to resources
    + Scroll down to find data management 
- Click on the static website
    + Click enable
    + Added index.html
    + Error.html
    + click save

- Find data storage
    + click on conatainer
    + click container to create container
        + give a name to the container
        + click on the container you name
        + click on upload to upload files

### To upload files and folders
 - Download Azure Microsoft storage explorer
    + Open the Azure Microsoft storage explorer
        + clikc on connect
        + Click on Storage acount or service
        + Click on connection string (Key or SAS)
    + Go back to webiste 
        + under Azure storage account
        + Find the security + networking
            + clcik on access keys
            + under key1, clikc show for` connection string`

![Azurestring](/img/Azurestring.png)

+ Copy the string and paste it into the connection string (Key or SAS) under 
    + click next to the connection string
    + click connect 

![EnterString](/img/EnterString.png)

- click on open storage account

    + open your Azure storage account
    + click on $web
    + click upload to upload

![Uploadazure](/img/upload.png)

- Upload the files or folder
    - File had uploaded to static website
-  Check if the file is uploaded

![static](/img/static.png)

- If file is uploaded
    + click on static website
    + copy the primary endpoint 
    + paste on your browser

![web](/img/web.png)
