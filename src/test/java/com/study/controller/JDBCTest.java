package com.study.controller;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {

	static { 
        try { 
            Class.forName("com.mysql.cj.jdbc.Driver"); 
        } catch(Exception e) { 
            e.printStackTrace(); 
        } 
    } 
    
    @Test 
    public void testConnection() { 
        try(Connection con = DriverManager.getConnection( 
                "jdbc:mysql://localhost:3306/workathome?serverTimezone=Asia/Seoul", 
                "root", 
                "!Q2w3e4r5t")){ 
            System.out.println(con); 
        } catch (Exception e) { 
            fail(e.getMessage()); 
        } 
    
    }    
	
	
	
	
}
