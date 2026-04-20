package com.anontrace.service;

import java.util.ArrayList;

public class MenuService {

	 public ArrayList<String> obtenerOpcionesInicio() {
		 	ArrayList<String> opciones = new ArrayList<String>();
	        opciones.add("CIUDADANO"); // Redirige a Formulario Directo
	        opciones.add("POLICIA");   // Redirige a Login
	        opciones.add("SOPORTE");   // Redirige a Admin
	        return opciones;
	    }
}
