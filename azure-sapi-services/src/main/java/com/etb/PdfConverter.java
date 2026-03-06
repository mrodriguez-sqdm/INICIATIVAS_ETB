package com.etb;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.imageio.ImageIO;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.ImageType;
import org.apache.pdfbox.rendering.PDFRenderer;

public class PdfConverter {
    
    /**
     * Convierte PDF a PNG y retorna los bytes directamente (sin guardar en disco)
     * @param pdfContent Contenido binario del PDF (puede ser ManagedCursorStreamProvider)
     * @param dpi Resolución de las imágenes
     * @return Array de byte arrays, donde cada elemento es un PNG
     * @throws Exception
     */
    public static byte[][] convertPdfToPngBytes(Object pdfContent, int dpi) throws Exception {
        
        // Convertir payload a InputStream
        InputStream pdfStream = null;
        
        try {
            if (pdfContent instanceof byte[]) {
                pdfStream = new ByteArrayInputStream((byte[]) pdfContent);
            } else if (pdfContent instanceof InputStream) {
                pdfStream = (InputStream) pdfContent;
            } else {
                // Manejar ManagedCursorStreamProvider específicamente
                try {
                    String className = pdfContent.getClass().getName();
                    
                    if (className.contains("ManagedCursorStreamProvider")) {
                        // Usar el método correcto: openCursor()
                        Object cursor = pdfContent.getClass()
                            .getMethod("openCursor")
                            .invoke(pdfContent);
                        
                        if (cursor instanceof InputStream) {
                            pdfStream = (InputStream) cursor;
                        } else {
                            throw new IllegalArgumentException("openCursor() no devolvió un InputStream");
                        }
                    } else {
                        // Intentar otros métodos comunes
                        try {
                            if (pdfContent.getClass().getMethod("getInputStream") != null) {
                                pdfStream = (InputStream) pdfContent.getClass()
                                    .getMethod("getInputStream")
                                    .invoke(pdfContent);
                            }
                        } catch (NoSuchMethodException e) {
                            // Método no existe, continuar
                        }
                        
                        // Si no se pudo convertir, intentar como String
                        if (pdfStream == null) {
                            String content = pdfContent.toString();
                            if (content.startsWith("%PDF")) {
                                pdfStream = new ByteArrayInputStream(content.getBytes());
                            } else {
                                throw new IllegalArgumentException("No se pudo convertir el contenido a InputStream válido");
                            }
                        }
                    }
                } catch (Exception e) {
                    throw new IllegalArgumentException("Error procesando el contenido: " + e.getMessage());
                }
            }
            
            if (pdfStream == null) {
                throw new IllegalArgumentException("No se pudo obtener un InputStream válido");
            }
            
            // Cargar PDF directamente desde InputStream
            PDDocument document = PDDocument.load(pdfStream);
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            
            int pageCount = document.getNumberOfPages();
            byte[][] pngBytes = new byte[pageCount][];
            
            // Convertir cada página directamente a bytes PNG
            for (int page = 0; page < pageCount; ++page) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, dpi, ImageType.RGB);
                
                // Convertir BufferedImage a bytes PNG
                ByteArrayOutputStream baos = new ByteArrayOutputStream();
                ImageIO.write(bim, "png", baos);
                pngBytes[page] = baos.toByteArray();
                baos.close();
            }
            
            document.close();
            return pngBytes;
            
        } finally {
            if (pdfStream != null) {
                try {
                    pdfStream.close();
                } catch (IOException e) {
                    System.err.println("Error cerrando stream: " + e.getMessage());
                }
            }
        }
    }
	
	
	
    /**
     * Convierte directamente el payload de Azure Storage de PDF a PNG
     * @param pdfContent Contenido binario del PDF (puede ser ManagedCursorStreamProvider)
     * @param outputDir Directorio de salida para las imágenes
     * @param dpi Resolución de las imágenes
     * @return Array con las rutas de las imágenes generadas
     * @throws Exception
     */
    public static String[] convertPdfToPng(Object pdfContent, String outputDir, int dpi) throws Exception {
        
        // Convertir payload a InputStream
        InputStream pdfStream = null;
        
        try {
            if (pdfContent instanceof byte[]) {
                pdfStream = new ByteArrayInputStream((byte[]) pdfContent);
            } else if (pdfContent instanceof InputStream) {
                pdfStream = (InputStream) pdfContent;
            } else {
                // Manejar ManagedCursorStreamProvider específicamente
                try {
                    String className = pdfContent.getClass().getName();
                    
                    if (className.contains("ManagedCursorStreamProvider")) {
                        // Usar el método correcto: openCursor()
                        Object cursor = pdfContent.getClass()
                            .getMethod("openCursor")
                            .invoke(pdfContent);
                        
                        if (cursor instanceof InputStream) {
                            pdfStream = (InputStream) cursor;
                        } else {
                            throw new IllegalArgumentException("openCursor() no devolvió un InputStream");
                        }
                    } else {
                        // Intentar otros métodos comunes
                        try {
                            if (pdfContent.getClass().getMethod("getInputStream") != null) {
                                pdfStream = (InputStream) pdfContent.getClass()
                                    .getMethod("getInputStream")
                                    .invoke(pdfContent);
                            }
                        } catch (NoSuchMethodException e) {
                            // Método no existe, continuar
                        }
                        
                        // Si no se pudo convertir, intentar como String
                        if (pdfStream == null) {
                            String content = pdfContent.toString();
                            if (content.startsWith("%PDF")) {
                                pdfStream = new ByteArrayInputStream(content.getBytes());
                            } else {
                                throw new IllegalArgumentException("No se pudo convertir el contenido a InputStream válido");
                            }
                        }
                    }
                } catch (Exception e) {
                    throw new IllegalArgumentException("Error procesando el contenido: " + e.getMessage());
                }
            }
            
            if (pdfStream == null) {
                throw new IllegalArgumentException("No se pudo obtener un InputStream válido");
            }
            
            // Cargar PDF directamente desde InputStream
            PDDocument document = PDDocument.load(pdfStream);
            PDFRenderer pdfRenderer = new PDFRenderer(document);
            
            int pageCount = document.getNumberOfPages();
            String[] imagePaths = new String[pageCount];
            
            // Convertir cada página directamente a PNG
            for (int page = 0; page < pageCount; ++page) {
                BufferedImage bim = pdfRenderer.renderImageWithDPI(page, dpi, ImageType.RGB);
                String fileName = outputDir + "/page_" + (page + 1) + ".png";
                ImageIO.write(bim, "png", new java.io.File(fileName));
                imagePaths[page] = fileName;
            }
            
            document.close();
            return imagePaths;
            
        } finally {
            if (pdfStream != null) {
                try {
                    pdfStream.close();
                } catch (IOException e) {
                    System.err.println("Error cerrando stream: " + e.getMessage());
                }
            }
        }
    }
}
