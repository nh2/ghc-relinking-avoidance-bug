# Critically, 

.PHONY: test
test:
	rm -rf .cabal-sandbox .cabal-sandbox*

	cabal sandbox init
	cabal install mylib1/
	mv .cabal-sandbox .cabal-sandbox.1
	
	cabal sandbox init
	cabal install mylib2/
	mv .cabal-sandbox .cabal-sandbox.2

	ln -s .cabal-sandbox.1 .cabal-sandbox

	cd myexe && cabal sandbox init --sandbox=../.cabal-sandbox

	cd myexe && cabal build
	cp myexe/dist/build/myexe/myexe myexe.1

	rm .cabal-sandbox
	ln -s .cabal-sandbox.2 .cabal-sandbox

	cd myexe && cabal build
	cp myexe/dist/build/myexe/myexe myexe.2

	@diff -u mylib1/Mylib.hs mylib2/Mylib.hs || true
	@echo

	./myexe.1
	./myexe.2

	@echo
	@bash -c "! cmp myexe.1 myexe.2" || (echo "TEST FAILED: GHC built same binary when the code was different" && false)


.PHONY: clean
clean:
	rm -rf .cabal-sandbox .cabal-sandbox* cabal.sandbox.config
	rm -rf mylib1/dist mylib2/dist
	rm -rf myexe/dist myexe/cabal.sandbox.config
	rm -rf myexe.1 myexe.2
