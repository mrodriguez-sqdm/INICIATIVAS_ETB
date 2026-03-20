package com.globant.utilities;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.Base64;
import org.mule.runtime.extension.api.annotation.param.MediaType;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.oned.Code128Writer;
import com.itextpdf.html2pdf.HtmlConverter;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.geom.Rectangle;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;

public class EtbUtilities {

	@MediaType("application/java")
    public String generateBarcode(String data, int width, int height) throws Exception {
            Code128Writer writer = new Code128Writer();
            BitMatrix matrix = writer.encode(data, BarcodeFormat.CODE_128, width, height);

            // Convertir el BitMatrix a una imagen en memoria
            ByteArrayOutputStream stream = new ByteArrayOutputStream();
            MatrixToImageWriter.writeToStream(matrix, "jpg", stream, new MatrixToImageConfig());
            // Obtener los bytes de la imagen
            byte[] barcodeBytes = stream.toByteArray();
            String base64Image = Base64.getEncoder().encodeToString(barcodeBytes);

            System.out.println("Barcode created");

            return base64Image;

    }

	public ByteArrayInputStream convertHtmlToPdf(String htmlContent, int width) throws Exception {
		int widthDefault = 21;
		if(width != 0) { widthDefault = width;}
		// Convertir cm a puntos (1 cm = 28.8 puntos)
		float widthInPoints = widthDefault * 28.8f;
		float margin = 10f;

		Rectangle box = new Rectangle(widthInPoints, PageSize.A4.getHeight());
		PageSize customPageSize = new PageSize(box);

		// Crear un ByteArrayOutputStream para almacenar el PDF
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		// Inicializar PdfWriter con el stream de salida
		PdfWriter writer = new PdfWriter(baos);

		// Inicializar el PdfDocument con el writer y el tamaño de página personalizado
		PdfDocument pdf = new PdfDocument(writer);
		pdf.setDefaultPageSize(customPageSize);
		// Crear el document con el tamaño de página personalizado
		Document document = new Document(pdf, customPageSize);
		document.setMargins(margin, margin, margin, margin);
		// Convertir HTML a PDF
		HtmlConverter.convertToPdf(htmlContent, pdf, null);

		// Cerrar el document y el PdfDocument
		document.close();
		pdf.close();
		System.out.println("PDF created");
		// Retornar el contenido del PDF como un ByteArrayInputStream
		return new ByteArrayInputStream(baos.toByteArray());
	}

	public ByteArrayInputStream convertTextToPdf(String text) throws Exception {
		// Crear un ByteArrayOutputStream para almacenar el PDF
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		// Inicializar PdfWriter con el stream de salida
		PdfWriter writer = new PdfWriter(baos);

		// Inicializar el PdfDocument con el writer
		PdfDocument pdf = new PdfDocument(writer);

		// Crear el Document con el PdfDocument
		Document document = new Document(pdf);

		// Agregar un párrafo con el texto al Document
		Paragraph paragraph = new Paragraph(text);
		document.add(paragraph);

		// Cerrar el Document y el PdfDocument
		document.close();
		pdf.close();
		System.out.println("PDF created");

		// Convertir el ByteArrayOutputStream a un ByteArrayInputStream
		ByteArrayInputStream inputStream = new ByteArrayInputStream(baos.toByteArray());

		return inputStream;
	}

	@MediaType("application/octet-stream")
	public InputStream convertToPdf(String content, boolean isHtml, int width) throws Exception {
		if (isHtml) {
			return this.convertHtmlToPdf(content, width);
		} 
		else {
			return this.convertTextToPdf(content);
		}
	}
	
	
	public String AES_Decrypt(String textToDecrypt, String secret, String iv) throws Exception {
		try {
			String ivDecoded = new String(Base64.getDecoder().decode(iv)) ;
	        byte[] _IV = new byte[ivDecoded.length() / 2];
	        byte[] _Key = secret.getBytes(StandardCharsets.UTF_8);
	
	        for (int i = 0; i < ivDecoded.length(); i += 2) {
	            _IV[i / 2] = (byte) Integer.parseInt(ivDecoded.substring(i, i+2), 16);
	        }
	
	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        SecretKeySpec keySpec = new SecretKeySpec(_Key, "AES");
	        IvParameterSpec ivSpec = new IvParameterSpec(_IV);
	        cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
	
	        byte[] cipherBytes = Base64.getDecoder().decode(textToDecrypt);
	        byte[] plainBytes = cipher.doFinal(cipherBytes);
	        return new String(plainBytes, StandardCharsets.UTF_8);
		} catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
    }
	
	public String AES_Decrypt_v2(String textToDecrypt, String secret, String iv) throws Exception {
		try {
	        byte[] _IV = new byte[iv.length() / 2];
	        byte[] _Key = secret.getBytes(StandardCharsets.UTF_8);
	
	        for (int i = 0; i < iv.length(); i += 2) {
	            _IV[i / 2] = (byte) Integer.parseInt(iv.substring(i, i+2), 16);
	        }
	
	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        SecretKeySpec keySpec = new SecretKeySpec(_Key, "AES");
	        IvParameterSpec ivSpec = new IvParameterSpec(_IV);
	        cipher.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);
	
	        byte[] cipherBytes = Base64.getDecoder().decode(textToDecrypt);
	        byte[] plainBytes = cipher.doFinal(cipherBytes);
	        return new String(plainBytes, StandardCharsets.UTF_8);
		} catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
    }
	
	public String[] AES_Encrypt(String text, String secret) throws Exception {
		try {
	        byte[] _IV = new byte[16];
	        byte[] _Key = secret.getBytes(StandardCharsets.UTF_8);
	
	        SecureRandom rng = new SecureRandom();
	        rng.nextBytes(_IV);
	
	        Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	        SecretKeySpec keySpec = new SecretKeySpec(_Key, "AES");
	        IvParameterSpec ivSpec = new IvParameterSpec(_IV);
	        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);
	
	        byte[] plainBytes = text.getBytes(StandardCharsets.UTF_8);
	        byte[] cipherBytes = cipher.doFinal(plainBytes);
	        String cipherText = Base64.getEncoder().encodeToString(cipherBytes);
	
	        StringBuilder hexString = new StringBuilder();
	        for (byte b : _IV) {
	            String hex = Integer.toHexString(0xFF & b);
	            if (hex.length() == 1) {
	                hexString.append('0');
	            }
	            hexString.append(hex);
	        }
	        return new String[] {cipherText, hexString.toString()};
	        
		} catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	
}
