package com.etb;

import com.microsoft.azure.storage.CloudStorageAccount;
import com.microsoft.azure.storage.StorageException;
import com.microsoft.azure.storage.blob.BlobContainerPermissions;
import com.microsoft.azure.storage.blob.BlobContainerPublicAccessType;
import com.microsoft.azure.storage.blob.CloudBlobClient;
import com.microsoft.azure.storage.blob.CloudBlobContainer;
import com.microsoft.azure.storage.blob.CloudBlockBlob;

public class AzureHandler {
		
	public static boolean makePublic(String accountName, String accountKey, String containerName) {
		String connectionString = "DefaultEndpointsProtocol=https;AccountName=" + accountName + ";AccountKey=" + accountKey;
		
		try {
			BlobContainerPermissions bcp = new BlobContainerPermissions();
			bcp.setPublicAccess(BlobContainerPublicAccessType.CONTAINER);
			
			CloudStorageAccount account = CloudStorageAccount.parse(connectionString);
            CloudBlobClient serviceClient = account.createCloudBlobClient();
            
            CloudBlobContainer container = serviceClient.getContainerReference(containerName);
            container.uploadPermissions(bcp);
            
            return true;
            
        }
        catch (StorageException storageException) {
            System.out.print("StorageException encountered: ");
            System.out.println(storageException.getMessage());
            return false;
        }
        catch (Exception e) {
            System.out.print("Exception encountered: ");
            System.out.println(e.getMessage());
            return false;
        }
	}
	
	public static boolean makeBlobPublicWithContentType(String accountName, String accountKey, String containerName, String blobName) {
		String connectionString = "DefaultEndpointsProtocol=https;AccountName=" + accountName + ";AccountKey=" + accountKey;
		
		try {
			BlobContainerPermissions bcp = new BlobContainerPermissions();
			bcp.setPublicAccess(BlobContainerPublicAccessType.CONTAINER);
			
			CloudStorageAccount account = CloudStorageAccount.parse(connectionString);
            CloudBlobClient serviceClient = account.createCloudBlobClient();
            
            CloudBlobContainer container = serviceClient.getContainerReference(containerName);
            container.uploadPermissions(bcp);
            
            CloudBlockBlob blob = container.getBlockBlobReference(blobName);

            // Set the Content-Type metadata
            blob.getProperties().setContentType("application/pdf");
            blob.uploadProperties();
            
            return true;
            
        }
        catch (StorageException storageException) {
            System.out.print("StorageException encountered: ");
            System.out.println(storageException.getMessage());
            return false;
        }
        catch (Exception e) {
            System.out.print("Exception encountered: ");
            System.out.println(e.getMessage());
            return false;
        }
	}
}