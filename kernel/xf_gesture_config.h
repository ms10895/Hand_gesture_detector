// Common Libraries
#ifndef _XF_THRESHOLD_CONFIG_H_
#define _XF_THRESHOLD_CONFIG_H_
#endif
#include "hls_stream.h"
#include "ap_int.h"
#include "common/xf_common.hpp"
#include "common/xf_utility.hpp"
#include "imgproc/xf_resize.hpp"


//CVT Libraries
#ifndef _XF_CVT_COLOR_CONFIG_H_
#define _XF_CVT_COLOR_CONFIG_H_
#endif
#include "imgproc/xf_cvt_color.hpp"
#include "imgproc/xf_cvt_color_1.hpp"
//#include "imgproc/xf_rgb2hsv.hpp"
#include "imgproc/xf_bgr2hsv.hpp"
#define _XF_SYNTHESIS_ 1 // Has to be set when synthesizing

// Inrage function Libraries
#include "imgproc/xf_inrange.hpp"

// Threshold Libraries
#include "imgproc/xf_threshold.hpp"




typedef ap_uint<64> ap_uint64_t;

#define RO 0 // Resource Optimized (8-pixel implementation)
#define NO 1 // Normal Operation (1-pixel implementation)

#define RGB 1
#define GRAY 0

#define INPUT_PTR_WIDTH 64
#define OUTPUT_PTR_WIDTH 64

#define MAXDOWNSCALE 2
#define INTERPOLATION 1


#define TYPE XF_8UC3
#define OUT_TYPE XF_8UC1

#define WIDTH 3840  // Maximum Input image width
#define HEIGHT 2160 // Maximum Input image height

/* Output image Dimensions */
#define NEWWIDTH 1920  // Maximum output image width
#define NEWHEIGHT 1080 // Maximum output image height

#define NPC_T XF_NPPC1

#define FILTER_WIDTH 5
#define FILTER_HEIGHT 5

#define THRESH_TYPE XF_THRESHOLD_TYPE_BINARY
