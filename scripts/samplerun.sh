mvn package

java -cp target/mg4j-1.0-SNAPSHOT-jar-with-dependencies.jar \
     it.unimi.di.big.mg4j.document.TRECDocumentCollection \
     -f HtmlDocumentFactory -p encoding=iso-8859-1 ~/dev/mg4j-tmp/out2.collection ~/dev/gov2/GX000/00.txt

# echo Building BitFunnel chunk files
java -cp target/mg4j-1.0-SNAPSHOT-jar-with-dependencies.jar \
     org.bitfunnel.reproducibility.GenerateBitFunnelChunks \
     -S ~/dev/mg4j-tmp/out2.collection ~/dev/mg4j-tmp/out2.chunk

# echo Building mg4j index . . .
java -cp target/mg4j-1.0-SNAPSHOT-jar-with-dependencies.jar \
     it.unimi.di.big.mg4j.tool.IndexBuilder \
      --keep-batches --downcase -S ~/dev/mg4j-tmp/out2.collection ~/dev/mg4j-tmp/out2

## Index build info
cat ~/dev/mg4j-tmp/out2-text.properties
cat ~/dev/mg4j-tmp/out2-title.properties

# echo Measuring query performance . . .
java -cp target/mg4j-1.0-SNAPSHOT-jar-with-dependencies.jar \
     org.bitfunnel.reproducibility.QueryPerformance \
     ~/dev/mg4j-tmp/out2 ~/dev/mg4j-workbench/data/small/queries10.txt
