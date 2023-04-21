#
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += \
	${PWD}/ring.v \
	$(PWD)/tb.v

TOPLEVEL = tb
MODULE = test

include $(shell cocotb-config --makefiles)/Makefile.sim
