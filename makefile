HLS_SRC ?= kernel/xf_gesture_config.h
HLS_TOP ?= gesture_accel
RTL_TOP := overlay
KERNEL := kernel


IP := hls-proj/s/impl/export.zip
BITSTREAM := rtl-proj/rtl.runs/impl_1/$(RTL_TOP).bit
HW_HANDOFF := rtl-proj/rtl.gen/sources_1/bd/$(RTL_TOP)/hw_handoff/$(RTL_TOP).hwh
.DEFAULT_GOAL := default

ip: $(IP)
hwh: $(HW_HANDOFF)
bit: $(BITSTREAM)

$(KERNEL): $(KERNEL)/vitis_lib
	
$(KERNEL)/vitis_lib:
	
	git clone --depth=1 https://github.com/Xilinx/Vitis_Libraries $@

hls $(IP): $(KERNEL)
	vitis_hls -f hls-proj.tcl

rtl bitstream $(BITSTREAM): $(IP)
	vivado -mode tcl -source rtl-proj.tcl

make-folder:
	mkdir overlay
copy-overlay: 
	cp -f $(BITSTREAM) overlay
	
copy-hwh:
	cp -f $(HW_HANDOFF) overlay

copy: make-folder copy-overlay copy-hwh

default: hls rtl copy

clean-vitis-lib:
	$(RM) -r -f $(KERNEL)/vitis_lib

clean-overlay:
	$(RM) -r -f $(RTL_TOP)
	
clean-hls-logs:
	$(RM) vitis_hls.log

clean-hls: clean-hls-logs
	$(RM) -r hls-proj

clean-rtl-logs:
	$(RM) vivado*.{log,jou}

clean-rtl: clean-rtl-logs
	$(RM) -r rtl-proj

clean: clean-rtl clean-hls clean-vitis-lib clean-overlay
