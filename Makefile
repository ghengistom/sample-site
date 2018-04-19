.PHONY: bundle

bundle:
	docker run -it --rm -v $(PWD):/usr/src/app --workdir /usr/src/app ruby:2.3 bundle