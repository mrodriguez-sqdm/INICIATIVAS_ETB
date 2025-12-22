package com.globant.Connectivity;

import org.apache.ws.security.WSConstants;
import org.apache.ws.security.WSEncryptionPart;
import org.apache.ws.security.components.crypto.Crypto;
import org.apache.ws.security.components.crypto.CryptoFactory;
import org.apache.ws.security.components.crypto.Merlin;
import org.apache.ws.security.message.WSSecHeader;
import org.apache.ws.security.message.WSSecSignature;
import org.apache.ws.security.message.WSSecTimestamp;
import org.apache.ws.security.message.token.DOMX509Data;
import org.apache.ws.security.message.token.DOMX509IssuerSerial;
import org.apache.ws.security.message.token.SecurityTokenReference;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.Reader;
import java.io.StringReader;
import java.security.KeyStore;
import java.security.cert.X509Certificate;
import java.util.Collections;
import java.util.Properties;

public class XmlSign {
	
    public String signXml(String inputXML,String passJks,String path,String aliasStr) {
        try {

            // Load the KeyStore
        	ClassLoader classLoader = getClass().getClassLoader();
            InputStream inputStream = classLoader.getResourceAsStream(path);
            KeyStore ks = KeyStore.getInstance("JKS");
            char[] password = passJks.toCharArray();
            ks.load(inputStream, password);
            
            // Get the private key and certificate from the KeyStore
            String alias = aliasStr;
            KeyStore.PrivateKeyEntry privateKeyEntry = (KeyStore.PrivateKeyEntry) ks.getEntry(alias,
                    new KeyStore.PasswordProtection(password));
            X509Certificate certificate = (X509Certificate) privateKeyEntry.getCertificate();
            
            // Load the XML document
            Document document = loadXMLDocument(inputXML);
            DOMX509IssuerSerial kiIssSer = new DOMX509IssuerSerial(document, certificate.getIssuerDN().getName(), certificate.getSerialNumber());
            DOMX509Data dataParent = new DOMX509Data(document, kiIssSer);

            // Create security token reference
            SecurityTokenReference secTokenRef = new SecurityTokenReference(document);
            secTokenRef.addWSSENamespace();
            secTokenRef.setX509Data(dataParent);
            WSEncryptionPart bodyPart = new WSEncryptionPart(WSConstants.ELEM_BODY, WSConstants.URI_SOAP11_ENV, "Content");
            Properties properties = new Properties();
            properties.setProperty("org.apache.ws.security.crypto.provider", "org.apache.ws.security.components.crypto.Merlin");
            Crypto crypto = CryptoFactory.getInstance(properties);
            ((Merlin) crypto).setKeyStore(ks);

            // Create a DOM XMLSignatureFactory
            WSSecSignature signature = new WSSecSignature();
            WSSecTimestamp timestamp = new WSSecTimestamp();
            WSSecHeader secHeader = new WSSecHeader();
            secHeader.insertSecurityHeader(document);
            signature.setUserInfo(alias, passJks);
            signature.setSignatureAlgorithm(WSConstants.RSA_SHA1);
            signature.setDigestAlgo(WSConstants.SHA1);
            signature.setUseSingleCertificate(true);
            signature.setSecurityTokenReference(secTokenRef);
            signature.setSigCanonicalization(WSConstants.C14N_EXCL_OMIT_COMMENTS);
            signature.prepare(document, crypto, secHeader);
            signature.addReferencesToSign(Collections.singletonList(bodyPart), secHeader);
            
            document = signature.build(document, crypto, secHeader);
            
            // Add TimeStamp
            timestamp.prepare(document);
            timestamp.prependToHeader(secHeader);

            // Save the signed document to a string
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.transform(new DOMSource(document), new StreamResult(outputStream));
            String signedXml = outputStream.toString();
            inputStream.close();

            return signedXml;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private static Document loadXMLDocument(String filePath) throws Exception {
    	DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder = factory.newDocumentBuilder();
        InputSource inputSource = new InputSource(new StringReader(filePath));
        Document document = builder.parse(inputSource);
        return document;
    }
}