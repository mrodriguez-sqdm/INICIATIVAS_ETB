package com.etb;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import javax.imageio.ImageIO;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;

public class PdfConverter {
    
    /**
     * Convierte PDF a PNG usando InputStream (más eficiente, sin cargar todo en memoria)
     */
    public static byte[][] convertPdfToPngBytes(InputStream pdfStream, int dpi) throws Exception {
        
        if (pdfStream == null) {
            throw new IllegalArgumentException("El InputStream no puede ser nulo");
        }
        
        try (PDDocument document = PDDocument.load(pdfStream)) {
            
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            int pageCount = document.getNumberOfPages();
            byte[][] pngBytes = new byte[pageCount][];
            
            for (int page = 0; page < pageCount; ++page) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, dpi, ImageType.RGB);
                
                try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
                    ImageIO.write(bim, "png", baos);
                    pngBytes[page] = baos.toByteArray();
                }
            }
            
            return pngBytes;
        }
    }
    
    /**
     * Sobrecarga para byte[] (fallback)
     */
    public static byte[][] convertPdfToPngBytes(byte[] pdfContent, int dpi) throws Exception {
        
        if (pdfContent == null || pdfContent.length == 0) {
            throw new IllegalArgumentException("El contenido PDF no puede ser nulo o vacío");
        }
        
        try (InputStream pdfStream = new java.io.ByteArrayInputStream(pdfContent)) {
            return convertPdfToPngBytes(pdfStream, dpi);
        }
    }
}