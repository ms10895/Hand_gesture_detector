open_project -reset hls-proj
set_top gesture_accel

set GESTURE_PATH kernel
set VISION_INC_PATH $GESTURE_PATH/vitis_lib/vision/L1/include

add_files $GESTURE_PATH/xf_gesture_config.h
add_files $GESTURE_PATH/xf_gesture_accel.cpp \
	-cflags "-I$VISION_INC_PATH -I. -I$GESTURE_PATH"

open_solution s
set_part xc7z020-1clg400

## create_clock -period 10ns
# Vitis uses a target frequency of 100 MHz, which corresponds to 10 ns clock
# period. If you specify a clock period, the Vitis can guess in the synthesis
# summary, if your design may meet the clock requirements. The actual max.
# frequency depends on the synthesis after the design is placed and routed.

config_interface -m_axi_addr64=0

csynth_design
export_design -format ip_catalog
exit
