NS = netsrfr
VERSION ?= latest
FLAGS =

.PHONY: build push deploy clean

build:
	cd kafka ; docker build $(FLAGS) -t $(NS)/kafka:$(VERSION) .
	cd post-processing ; docker build $(FLAGS) -t $(NS)/backbeat:$(VERSION) .
	cd s3 ; docker build $(FLAGS) -t $(NS)/s3:$(VERSION) .
	cd post-processing/zensational ; docker build $(FLAGS) -t $(NS)/post_processing_consumer:$(VERSION) .

push:
	cd kafka ; docker push $(NS)/kafka:$(VERSION)
	cd post-processing ; docker push $(NS)/backbeat:$(VERSION)
	cd s3 ; docker push $(NS)/s3:$(VERSION)
	cd post-processing/zensational ; docker push $(NS)/post_processing_consumer:$(VERSION)

deploy:
	docker stack deploy -c docker-stack.yml zenko-prod

clean:
	docker stack rm zenko-prod
