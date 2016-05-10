SOURCE = README.md

build:
	rsync -a resources/ build/
	rsync -a img/ build/img/
	bash md2deckprettyprez.sh $(SOURCE) 'Drupal + Blackfire = ❤️' > build/out.html

clean:
	rm build/out.html

serve:
	@echo Serving on http://localhost:7777/out.html
	cd build/; python -m SimpleHTTPServer 7777

WATCH = README.md
watch:
	fswatch $(WATCH) | while read; do make serve >& /dev/null; done &

.PHONY: build
