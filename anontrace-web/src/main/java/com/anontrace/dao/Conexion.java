package com.anontrace.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
	 Connection connect = null;
	    String url = "jdbc:sqlserver://DESKTOP-5I4L21C\\SVR1:1433;databaseName=";
	    
	    public Connection getConexion(){
	        
	        try{
	            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	            System.out.print("Driver Instalado Correctamente"+"\n");
	        }catch(ClassNotFoundException e){
	            System.out.print("Error de Driver"+e.getMessage());
	        }
	        
	        try{
	        	connect = DriverManager.getConnection(url,"sa","987321546");
	            System.out.print("Conexion de base de datos exitosa"+"\n");
	        }catch(SQLException e){
	            System.out.print("Error SQL Esception"+e.getMessage());
	        }
	        
	        return connect;
	    }
}
