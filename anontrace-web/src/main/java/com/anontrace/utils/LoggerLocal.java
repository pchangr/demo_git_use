package com.anontrace.utils;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class LoggerLocal {
    
    // Definimos la ruta relativa a la raíz del proyecto
    private static final String FOLDER_PATH = "logs";
    private static final String FILE_NAME = FOLDER_PATH + File.separator + "errores_sistema.txt";

    public static void registrarError(String mensaje, Exception e) {
        try {
            // 1. Verificar si la carpeta existe, si no, crearla
            File directorio = new File(FOLDER_PATH);
            if (!directorio.exists()) {
                directorio.mkdirs();
            }

            // 2. Escribir el error en el archivo (append = true para no borrar lo anterior)
            try (FileWriter fw = new FileWriter(FILE_NAME, true);
                 PrintWriter pw = new PrintWriter(fw)) {
                
                DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                
                pw.println("===========================================");
                pw.println("FECHA/HORA: " + dtf.format(LocalDateTime.now()));
                pw.println("MENSAJE: " + mensaje);
                pw.println("EXCEPCIÓN: " + e.toString());
                
                // Esto guarda toda la traza del error (clase y línea exacta donde falló)
                e.printStackTrace(pw); 
                pw.println("===========================================\n");
            }
        } catch (Exception ex) {
            System.err.println("No se pudo escribir en el log: " + ex.getMessage());
        }
    }
}