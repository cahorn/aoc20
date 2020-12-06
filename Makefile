DAYS=$(basename $(wildcard d??.hs))

CPPFLAGS=-XCPP
HSFLAGS=-no-keep-hi-files -no-keep-o-files -dynamic

BIN=$(addsuffix p1, $(DAYS)) $(addsuffix p2, $(DAYS))
LIB=AoC20Lib.hs

.PHONY=all
all: $(BIN)

%p1: %.hs $(LIB)
	ghc $(CPPFLAGS) $(HSFLAGS) -o $@ $<

%p2: %.hs $(LIB)
	ghc $(CPPFLAGS) -DPART2 $(HSFLAGS) -o $@ $<

.PHONY=clean
clean:
	$(RM) $(BIN)
