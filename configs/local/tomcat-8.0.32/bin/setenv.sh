# -Xdebug -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n

CATALINA_OPTS="$CATALINA_OPTS \
-Dfile.encoding=UTF8 \
-Djava.net.preferIPv4Stack=true \
-Dorg.apache.catalina.loader.WebappClassLoader.ENABLE_CLEAR_REFERENCES=false \
-Duser.timezone=GMT \
-Xmx2048m -Xms2048m"