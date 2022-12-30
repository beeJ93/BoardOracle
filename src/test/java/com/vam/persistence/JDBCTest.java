package com.vam.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class JDBCTest {
   static {
      try {
         Class.forName("oracle.jdbc.OracleDriver");
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   @Test
   public void testConnection() {
      try(Connection con = DriverManager.getConnection(
               "jdbc:oracle:thin:@localhost:1521:orcl",
               "scott",
               "tiger"
            )) {
         System.out.println(con);
         
      } catch (Exception e) {
         fail(e.getMessage());
      }
   }
}