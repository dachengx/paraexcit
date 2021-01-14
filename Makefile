SHELL:=bash
imgfold:=Note/img
n:=$(shell seq -f '%1.01f' 0.5 0.1 5)
beta:=0.0001 0.0010 0.0100 0.1000

erg:=$(shell for i in $(n); do for j in $(beta); do echo $${i}-$${j}; done; done)
erg:=$(word $(words $(erg)),$(erg))
reco:=$(erg:%=record/%.h5)

.PHONY : all

all : $(imgfold)/demo.png

reco : $(reco)

record/%.h5 : 
	@mkdir -p $(dir $@)
	wolframscript -file simu.wl $* $@ > $@.log 2>&1

$(imgfold)/demo.png : reco
	@mkdir -p $(dir $@)
	wolframscript -file demo.wl record/ $@ > $@.log 2>&1