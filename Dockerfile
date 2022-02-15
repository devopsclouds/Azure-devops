FROM maven:3.5-jdk-8 AS build
	WORKDIR /usr/src/app
	COPY src ./src
	ADD settings.xml .
	COPY pom.xml .
	RUN mvn -f /usr/src/app/pom.xml clean -Dmaven.test.skip=true package deploy
	

	

	FROM dordoka/tomcat
	COPY --from=build /usr/src/app/target/*.war /opt/tomcat/webapps/customerapp.war
	EXPOSE 8080
	CMD ["/opt/tomcat/bin/catalina.sh", "run"]

