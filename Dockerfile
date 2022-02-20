FROM maven:3.5-jdk-8 AS build
	WORKDIR /usr/src/app
	COPY src ./src
	COPY pom.xml .
	RUN mkdir -p /root/.m2 \
    && mkdir /root/.m2/repository
# Copy maven settings, containing repository configurations
	COPY settings.xml /root/.m2
	
	RUN mvn -s /root/.m2/settings.xml clean -Dmaven.test.skip=true package deploy
	

	

	FROM dordoka/tomcat
	COPY --from=build /usr/src/app/target/*.war /opt/tomcat/webapps/customerapp.war
	EXPOSE 8080
	CMD ["/opt/tomcat/bin/catalina.sh", "run"]

