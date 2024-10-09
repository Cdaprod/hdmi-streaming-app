APP_NAME = streaming-app
DOCKER_REPO = Cdaprod/hdmi-streaming-app

build:
    docker build -t $(DOCKER_REPO):latest .

run:
    docker run -p 8080:8080 -p 80:80 $(DOCKER_REPO):latest

push:
    docker push $(DOCKER_REPO):latest

deploy:
    docker-compose up --build