FROM tomcat:9.0

# Remove default web applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy custom index.html to the ROOT webapp
COPY index.html /usr/local/tomcat/webapps/ROOT/index.html

