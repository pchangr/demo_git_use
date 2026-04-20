package com.anontrace.service;

import com.anontrace.dao.IncidenciaDao;
import com.anontrace.utils.LoggerLocal;

public class IncidenciaService {

	IncidenciaDao dao = new IncidenciaDao();
	
	
	// Versión 1: Reporte ultra-rápido (solo ubicación y tipo)
	public String registrarReporte(double lat, double lon, String tipo) {
		 try{
	            dao.registrarReporteDao(lat,lon,tipo);
	            return "OK"; 
	            
	        }catch(Exception e){
	        	
	        	// 1. Logger
	            LoggerLocal.registrarError("Fallo al registrar reporte de tipo: " + tipo, e);
	            
	            // 2. Pop-up error
	        	return "Error: No se pudieron procesar los datos del avistamiento.";
	        	
	        }
	}

	// Versión 2: Reporte con descripción (Sobrecargado)
	public String registrarReporte(double lat, double lon, String tipo, String descripcion) { 
		 try{
	            dao.registrarReporteDao(lat,lon,tipo,descripcion);
	            return "OK"; 
	            
	        }catch(Exception e){
	        	
	        	// 1. Logger
	            LoggerLocal.registrarError("Fallo al registrar reporte de tipo: " + tipo, e);
	            
	            // 2. Pop-up error
	        	return "Error: No se pudieron procesar los datos del avistamiento.";
	        	
	        }
	}

	// Versión 3: Reporte con evidencia/foto (Sobrecargado)
	public String registrarReporte(double lat, double lon, String tipo, String descripcion, String urlFoto) { 
		 try{
	            dao.registrarReporteDao(lat,lon,tipo,urlFoto);
	            return "OK"; 
	            
	        }catch(Exception e){
	        	
	        	// 1. Logger
	            LoggerLocal.registrarError("Fallo al registrar reporte de tipo: " + tipo, e);
	            
	            // 2. Pop-up error
	        	return "Error: No se pudieron procesar los datos del avistamiento.";
	        	
	        }
	}

}
