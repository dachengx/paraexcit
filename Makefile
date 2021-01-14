SHELL:=bash
imgfold:=Note/img
n:=$(shell seq -f '%1.02f' 0.2 0.2 1.6 && seq -f '%1.02f' 1.7 0.05 2.3 && seq -f '%1.02f' 2.4 0.2 3 && seq -f '%1.02f' 3.5 0.5 5)
beta:=$(shell seq -f '%1.02f' 0 0.02 0.1)

erg:=$(shell for i in $(n); do for j in $(beta); do echo $${i}-$${j}; done; done)
# erg:=$(word $(words $(erg)),$(erg))
reco:=$(erg:%=record/%.h5)

.PHONY : all

all : $(imgfold)/done.png

reco : $(reco)

record/%.h5 : 
	@mkdir -p $(dir $@)
	wolframscript -file simu.wl $* $@ > $@.log 2>&1

$(imgfold)/done.png : reco
	@mkdir -p $(dir $@)
	wolframscript -file demo.wl record/ $(imgfold)/ > $@.log 2>&1
	@touch $@

clean : 
	pushd record; rm -r ./* ; popd