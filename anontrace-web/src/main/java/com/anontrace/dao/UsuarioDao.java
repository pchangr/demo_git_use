package com.anontrace.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UsuarioDao {
	
	Conexion conexion = new  Conexion();
    Connection cn = conexion.getConexion();
    
     public String Login(String usuario, String contraseña){
        String sql = "{call SP_LOGINUSER(?,?,?)}";
        System.out.println(sql);
        
        String cargo="";
        
        try {
            CallableStatement call = cn.prepareCall(sql);
            
            call.setString(1,usuario);
            call.setString(2,contraseña);
            
            try (ResultSet rs = call.executeQuery()){
            	if (rs.next()) return cargo = rs.getString(1);
            }
          
                call.close();
                cn.close();
        }catch(SQLException e ){
            System.out.println("Error de Consulta "+ e.getMessage());
            
        }
        
        return cargo;
     }
}
