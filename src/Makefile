#
SIM               ?= icarus
TOPLEVEL_LANG     ?= verilog
TOPLEVEL           = tb
VERILOG_SOURCES   += $(PWD)/tb.v

ifeq ($(GATES),yes)

  COMPILE_ARGS    += -DGL_TEST
  COMPILE_ARGS    += -DFUNCTIONAL
  COMPILE_ARGS    += -DUSE_POWER_PINS
  COMPILE_ARGS    += -DSIM
  COMPILE_ARGS    += -DUNIT_DELAY=#1
  VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
  VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v
  VERILOG_SOURCES += $(PWD)/gate_level_netlist.v
  MODULE           = gate_test

else

  VERILOG_SOURCES +=                                \
			$(PWD)/dwisehart_ring_top.v \
			$(PWD)/ringd.v              \
			$(PWD)/scan.v               \
			$(PWD)/LED.v                \
			$(PWD)/capture.v            \
			$(PWD)/grey_1000.v          \
			$(PWD)/grey_10.v            \
			$(PWD)/slow_grey.v
  MODULE           = test

endif

include $(shell cocotb-config --makefiles)/Makefile.sim
