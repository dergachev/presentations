build:
	rsync -a resources/ build/
	bash md2deckprettyprez.sh README.md > build/out.html

clean:
	rm build/out.html

serve:
	@echo Serving on http://localhost:7777/out.html
	cd build/; python -m SimpleHTTPServer 7777

.PHONY: build
