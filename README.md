#Notebook
###Notebook is an application which can be used to persist person's names and phone numbers.
======================================

##Requirements
Apache Maven and MySQL Server need to be installed on your PC to run this project.


##Install
This is a maven project, to build it, run from project directory:

    $ mvn clean package


##Usage
To run project `com.softindustry.main.Main`via embedded Jetty:

    $ mvn exec:exec

Open your web browser to:

    http://localhost:8080/  

To stop Jetty:

  use <kbd>CTRL</kbd>+<kbd>C</kbd>
  
##Technologies used
Development of the application involved usage of JSP, Servlet API, Jetty(embedded), JDBC, MySQL.
