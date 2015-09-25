all: build publish

stability?=latest

login:
	@vagrant ssh -c "docker login"

build:
	@echo "Building 'runit' image..."
	@vagrant ssh -c "docker build -t nanobox/runit /vagrant"

publish:
	@echo "Tagging 'runit' image..."
	@vagrant ssh -c "docker tag -f nanobox/runit nanobox/runit:${stability}"
	@echo "Publishing 'runit:${stability}'..."
	@vagrant ssh -c "docker push nanobox/runit:${stability}"

clean:
	@echo "Removing all images..."
	@vagrant ssh -c "for image in $(docker images -q); do docker rmi -f $image; done"
