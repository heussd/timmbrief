SHELL   := bash
.SHELLFLAGS := -eu -o pipefail -c  
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

default: latex-letter/* latex clean

latex-letter/*: ## Checkout latex-letter submodule
	@git clone --depth 1 https://github.com/andre-lehnert/latex-letter

latex-letter-patch: ## Patch to don't show own name, allowing big logo
	@awk 'NR>304&&NR<309{$$0="%"$$0}1' latex-letter/tfbrief.cls > lala
	@mv lala latex-letter/tfbrief.cls

vcard.tex: ## Retrieves personal data from the Contacts app 
	@echo "Trying to access Contracts, requires Privacy permission to Contacts and Automation"
	@osascript -e 'tell application "Contacts" to get my card' > /dev/null && echo "✅ Sucessfully accessed Contracts!"
	@echo '%!TEX root = cv.tex' > vcard.tex
	@echo "% This file is auto generated by Makefile." >> vcard.tex
	@echo "" >> vcard.tex
	@echo "\def\vcardfromname{$$(osascript -e 'tell application "Contacts" to get name of my card')}" >> vcard.tex
	@echo "\def\vcardfromstreet{$$(osascript -e 'tell application "Contacts" to get street of address 1 of my card')}" >> vcard.tex
	@echo "\def\vcardfromcitycode{$$(osascript -e 'tell application "Contacts" to get zip of address 1 of my card')}" >> vcard.tex
	@echo "\def\vcardfromcity{$$(osascript -e 'tell application "Contacts" to get city of address 1 of my card')}" >> vcard.tex
	@echo "\def\vcardfromcityshort{$$(osascript -e 'tell application "Contacts" to get first word of (city of address 1 of my card as string)')}" >> vcard.tex
	@echo "\def\vcardfrommobile{$$(osascript -e 'tell application "Contacts" to get value of phone 1 of my card')}" >> vcard.tex
	@echo "\def\vcardfromemail{$$(osascript -e 'tell application "Contacts" to get value of email 1 of my card')}" >> vcard.tex
	@echo "\def\vcardbirthdayYYYY{$$(osascript -e 'tell application "Contacts" to get year of (get the birth date of my card)')}" >> vcard.tex
	@echo "\def\vcardbirthdayMM{$$(osascript -e 'tell application "Contacts" to get month of (get the birth date of my card)')}" >> vcard.tex
	@echo "\def\vcardbirthdayDD{$$(osascript -e 'tell application "Contacts" to get day of (get the birth date of my card)')}" >> vcard.tex
	@echo "\def\vcardfamily{$$(osascript -e 'tell application "Contacts" to note of my card')}" >> vcard.tex

	@tccutil reset AddressBook && echo "✅ Recoved access to Contracts again"
	@tccutil reset AppleEvents && echo "✅ Recoved access to Automation again"


latex: latex-letter vcard.tex
	xelatex -halt-on-error "$$(ls -1 *.tex | grep -v "vcard" | grep -v "timmbrief")"
	open *.pdf

clean: ## Remove temporal compilation artifacts
	@-rm *.aux *.log *.aux *.bbl *.glg *.blg *.toc *.out *.idx *.ilg *.ind *.lof *.lol

help: # http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@grep -E '^[a-z].*:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'