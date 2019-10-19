JFLAGS = -g
JC = javac
JVM= java
.SUFFIXES: .java .class

.java.class:
	$(JC) $(JFLAGS) $*.java

CLASSES = program1.java

default: run

run: program1.class
	$(JVM) -cp ./:/usr/share/java/mysql.jar program1