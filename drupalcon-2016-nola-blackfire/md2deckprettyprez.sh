# input argument should be path to markdown file
# writes output on stdout
# for an example presentation look at https://github.com/amirkdv/presentations/tree/gh-pages
# to indicate end of slide in markdown file use
# ---end--- (no space, any number of {-}s >1 )
# for example:
# ##h2 title
# some stuff
# maybe a list:
# * item1
# * item2
# --end------
# to indicate syntax highlighting language for code blocks
# start them with #{language_name}
# for example:
# ##h2 title
# some stuff
# now a code block
#
#     #ruby
#     :bob = "bob".to_sym
#
# --end----
# the head and tail of the output html are expected to be at
# ./resources/{head,tail}.html
# you should link all your external resources there
#! /bin/bash

echo "<!DOCTYPE html><html><head>"
echo "<title>$2</title>"
cat resources/head.html
echo "</head><body class='deck-container'><section class='slide'>"
LOGO_DIV="<div\ style='position:absolute;width:500px;bottom:0;right:1em;'><img\ src='resources\/img\/'\ width='200px'\ style='float:right;'\/><\/div>"
test -f resources/img/ || LOGO_DIV=""
cat $1 | sed 's/-\{2,\}end-\{2,\}/\'$'\n''--end--\'$'\n/' \
      | markdown \
      | perl -pe 's,^HIGHLIGHT(.*)$,<span class="ungrey">$1</span>,' \
      | sed 's/<code>\s*#\+\([a-zA-Z]*\)/<code class="language-\1">/' \
      | sed 's/<pre>/<pre class="prettyprint">/' \
      | sed "s/<p>--end--<\/p>/$LOGO_DIV<\/section><section class='slide'>/" \

echo "</section>"
cat resources/tail.html
echo "</body></html>"
