# Jenkins

Jenkins is an open source automation server. It helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Jenkins CI|Automation Server|[`jenkins/jenkins:lts`](https://hub.docker.com/r/jenkins/jenkins)|<http://localhost:8080>|
|Jenkins SSH Agent|Build Agent|[`jenkins/ssh-agent:jdk11`](https://hub.docker.com/r/jenkins/ssh-agent)|N/A|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

```powershell
ssh-keygen -t rsa -f jenkins_agent -C " "
```

## References

- <https://www.cloudbees.com/blog/how-to-install-and-run-jenkins-with-docker-compose>
