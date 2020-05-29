SAMPLES := $(basename $(wildcard samples/*.c))

%: %.c
	clang -emit-llvm -S -fno-discard-value-names -c -o $@.ll $<
	opt -load ../build/SamplePass.so -samplepass -S $@.ll -disable-output

all: $(SAMPLES)

clean:
	rm -f samples/*.ll
