USER_UID = $(shell id -u $(USER))
USER_GID = $(shell id -g $(USER))

build:
	docker build -t dockerbb .

squash:
	docker build -t dockerbb --squash --force-rm .

dev:
	docker build -t dockerbb .

start:
	-docker stop dockerbb
	-docker rm -f dockerbb
	docker run -it --rm --name dockerbb \
		-e USER_UID=$(USER_UID) \
		-e USER_GID=$(USER_GID) \
		--shm-size 100m \
		--net host \
		--hostname $(shell hostname) \
		-e XSOCK \
		-e XAUTH \
		-e DISPLAY \
		-v "$(HOME)/.Xauthority:/root/.Xauthority:rw" \
		--cap-add SYS_ADMIN \
		-v "$(HOME)/dockerbb-data:/home/user" \
		dockerbb www.bb.com.br

stop:
	-docker stop dockerbb
	-docker rm  -f dockerbb

logs:
	docker logs -f dockerbb
