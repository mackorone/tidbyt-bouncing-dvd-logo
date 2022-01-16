.PHONY: build clean lint

build:
	pixlet render *.star

clean:
	rm -f *.webp

lint:
	buildifier *.star
