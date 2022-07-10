run:
	docker run --rm --user="root" -it nvim-computer bash
build:
	docker build -t nvim-computer .
remove:
	docker rmi `docker images | grep 'nvim-computer'`
install:
	ansible-playbook config.yaml
