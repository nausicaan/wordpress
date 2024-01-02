develop: clean build run

clean:
	docker-compose rm -vf
	docker-compose down 

build:
	docker buildx bake -f docker-compose.yaml \
		--set app.args.DOCKER_REGISTRY=docker.io/library