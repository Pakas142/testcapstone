if [ "$GIT_BRANCH" = "origin/dev" ]; then
	docker stop $(docker ps -aq)
    docker image prune -af
    docker build -t $IMAGE_NAME .
    docker login -u pakas142 -p Pakas@142
    docker tag $IMAGE_NAME pakas142/dev:latest
    docker push pakas142/dev:latest
	sed 's|{{IMAGE_NAME}}|${IMAGE_NAME}|' docker-compose.template.yml > docker-compose.yml
    docker ps
elif [ "$GIT_BRANCH" = "origin/master" ]; then
	docker stop $(docker ps -aq)
    docker image prune -af
    docker build -t $IMAGE_NAME .
    docker login -u pakas142 -p Pakas@142
    docker tag $IMAGE_NAME pakas142/prod:latest
    docker push pakas142/prod:latest
	sed 's|{{IMAGE_NAME}}|${IMAGE_NAME}|' docker-compose.template.yml > docker-compose.yml
    docker ps
else echo "either git pull not available in dev or master"
fi

