all: build publish

stability?=latest

login:
	@vagrant ssh -c "docker login"

build:
	@echo "Building 'runit' image..."
	@vagrant ssh -c "docker build -t nanobox/runit /vagrant"

publish:
	@echo "Tagging 'runit' image..."
	@vagrant ssh -c "docker tag nanobox/runit nanobox/runit:${stability}"
	@echo "Publishing 'runit:${stability}'..."
	@vagrant ssh -c "docker push nanobox/runit:${stability}"

PHONY: clean clean-base clean-project

clean: clean-base
	@echo "Removing all images..."
	@vagrant ssh -c "for image in \$$(docker images -q | sort | uniq); do docker rmi -f \$$image; done"

clean-base: clean-project
	@echo "Removing base images..."
	@vagrant ssh -c "for image in \$$(docker images -q nanobox/base | sort | uniq); do docker rmi -f \$$image; done"

clean-project:
	@echo "Removing runit images..."
	@vagrant ssh -c "for image in \$$(docker images -q nanobox/runit | sort | uniq); do docker rmi -f \$$image; done"