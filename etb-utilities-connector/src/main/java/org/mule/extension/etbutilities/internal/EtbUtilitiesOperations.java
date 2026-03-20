package org.mule.extension.etbutilities.internal;
import java.io.InputStream;
import org.mule.runtime.extension.api.annotation.param.MediaType;
import com.globant.utilities.EtbUtilities;

/**
 * This class is a container for operations, every public method in this class will be taken as an extension operation.
 */
public class EtbUtilitiesOperations {
	
	
    @MediaType("application/java")
    public String generateBarcode(String data, int width, int height) throws Exception {
    	EtbUtilities utilityClass = new EtbUtilities();
    	return utilityClass.generateBarcode(data, width, height);
    }

    @MediaType("application/octet-stream")
	public InputStream convertToPdf(String content, boolean isHtml, int width) throws Exception {
    	EtbUtilities utilityClass = new EtbUtilities();
     	return utilityClass.convertToPdf(content, isHtml, width);
	}
    
    @MediaType("application/java")
    public String decryptAES(String textToDecrypt, String secret, String iv) throws Exception {
    	EtbUtilities utilityClass = new EtbUtilities();
    	return utilityClass.AES_Decrypt(textToDecrypt, secret, iv);
    }
    
    @MediaType("application/java")
    public String[] encryptAES(String textToEncrypt, String secret) throws Exception {
    	EtbUtilities utilityClass = new EtbUtilities();
    	return utilityClass.AES_Encrypt(textToEncrypt, secret);
    }

    @MediaType("application/java")
    public String decryptAESv2(String textToDecrypt, String secret, String iv) throws Exception {
    	EtbUtilities utilityClass = new EtbUtilities();
    	return utilityClass.AES_Decrypt_v2(textToDecrypt, secret, iv);
    }

}