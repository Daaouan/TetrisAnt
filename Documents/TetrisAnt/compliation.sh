#!/bin/bash

# cleanup le répertoire bin
rm -rf bin/*
mkdir -p bin

# compilation 
javac -d bin/ -classpath lib/commons-lang3-3.5.jar src/fr/ubo/tetris/*.java

# création du fichier JAR
cd bin
jar -cf Tetris.jar fr
cd ..

# exécution 
java -cp bin/Tetris.jar:lib/commons-lang3-3.5.jar fr.ubo.tetris.Tetris
