echo Cleaning resources...
call mvn clean
echo Assembling app...
call mvn package
echo Starting app...
call mvn exec:java
