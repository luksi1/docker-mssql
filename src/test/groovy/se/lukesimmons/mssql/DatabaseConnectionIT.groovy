#!/usr/bin/env groovy

import java.sql.*;
import java.util.Enumeration;
import java.io.*;
import junit.framework.Test
import junit.textui.TestRunner
import static org.hamcrest.MatcherAssert.assertThat
import static org.hamcrest.Matchers.is
import static org.hamcrest.Matchers.equalTo
import static org.junit.matchers.JUnitMatchers.*

class DatabaseConnectionIT extends GroovyTestCase {

  void testConnection() {
    def result 
    def database_name = "test"
    def username = "luksi1"
    def password = "Abcd1234"
    def properties = new Properties()
    def propertiesFile = new File('/tmp/mssql.port.properties')
    propertiesFile.withInputStream {
      properties.load(it)
    }
    def database_port = properties."database.random.port"
    def url = "jdbc:jtds:sqlserver://localhost:${database_port}/${database_name}"
   
    try {
      Class.forName("net.sourceforge.jtds.jdbc.Driver");
      def conn = DriverManager.getConnection (url, username,password);
      result = "Success"
    } catch (Exception e) {
        result = "Failed"
        throw new RuntimeException(e.printStackTrace());
    }

    assertThat(result, containsString("Success"))

  }

  void testConnectionFailsWithWrongPassword() {
    def database_name = "test"
    def username = "luksi1"
    def password = "Abcd123"
    def properties = new Properties()
    def propertiesFile = new File('/tmp/mssql.port.properties')
    propertiesFile.withInputStream {
      properties.load(it)
    }
    def database_port = properties."database.random.port"
    def url = "jdbc:jtds:sqlserver://localhost:${database_port}/${database_name}"
   
    String message = shouldFail( SQLException ) {
      Class.forName("net.sourceforge.jtds.jdbc.Driver")
      def conn = DriverManager.getConnection (url, username,password)
    } 

  }
 
}

