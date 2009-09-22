
WGET_OPTS := -q
WGET := wget
XMLLINT := xmllint
XMLLINT_OPTS := --xmlout --format --nonet
HTMLTIDY := tidy
HTMLTIDY_OPTS := -i -config config/htmltidy.cfg


donate_URL := 'http://www.ceskapiratskastrana.cz/pages/podporte-nas/financni-dary.php'
donate_XPATH := '//*[@id="content"]'
#donate_XMLLINT := --html
#donate_HTMLTIDY := -utf8 --input-encoding utf8
donate_ICONV := cat

transList_URL := 'https://www.fio.cz/scgi-bin/hermes/dz-transparent.cgi?ID_ucet=2100048174'
transList_XPATH := '//table[@class="table_prm"]'
#transList_XMLLINT := --encode utf8 --html
#transList_HTMLTIDY := -utf8 --input-encoding win1250
transList_ICONV := iconv -c -f windows-1250 -t utf-8

faq_URL := 'http://www.ceskapiratskastrana.cz/pages/tiskovy-servis/otazky-a-odpovedi.php'
faq_XPATH := $(donate_XPATH)
faq_ICONV := $(donate_ICONV)

buy-a-shirt_URL := 'http://www.ceskapiratskastrana.cz/pages/podporte-nas/prodej-tricek.php'
buy-a-shirt_XPATH := $(donate_XPATH)
buy-a-shirt_ICONV := $(donate_ICONV)



PAGES := transList.php donate.php faq.php buy-a-shirt.php

.SUFFIXES:
.SUFFIXES: .php .html .xhtml .xml .html.lck
.PHONY: clean $(PAGES:.php=_URL) pushFBML
.PRECIOUS: $(PAGES:.php=.html) %.html.lck

all: transList.xhtml pushFBML

pushFBML: transList.xhtml
	sh getsum.sh
	php pushFBML.php

%.html.lck:
	touch ${@}

%.html: %.html.lck
	$(WGET) $(WGET_OPTS) $($(@:.html=_URL)) -O ${@}
	touch -r ${@} -d '+60 minutes' ${@}.lck


#%.xml: %.html
#	 $(XMLLINT) $(XMLLINT_OPTS) $(@:.xml=.html) ${$(@:.xml=_XMLLINT)} -o ${@}

%.xhtml: %.html
	$($(@:.xhtml=_ICONV)) < $(@:.xhtml=.html) > $(@:.xhtml=.html.tmp)
	if [[ ! $$(  $(HTMLTIDY) $(HTMLTIDY_OPTS) $($(@:.xhtml=_HTMLTIDY))  -f $(@).log $(@:.xhtml=.html.tmp) > ${@} ) && $$? -ne 1 ]]; then /bin/false; fi

%.php: %.xhtml
	xpath $(@:.php=.xhtml) $($(@:.php=_XPATH)) > ${@}

EXTS := $(PAGES:.php=.html) $(PAGES:.php=.xml) $(PAGES:.php=.xhtml) $(PAGES) $(PAGES:=.lck)

clean::
	-rm ${EXTS} *.log

distclean::
	-rm ${EXTS} *.log

