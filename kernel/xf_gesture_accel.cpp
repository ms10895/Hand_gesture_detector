#include "xf_gesture_config.h"


extern "C" {
void gesture_accel(
		ap_uint<INPUT_PTR_WIDTH>* img_inp,
		ap_uint<OUTPUT_PTR_WIDTH>* img_out,
		int rows,
		int cols,
		ap_uint<INPUT_PTR_WIDTH>* lower_threshold,
		ap_uint<INPUT_PTR_WIDTH>* upper_threshold,
		unsigned char thresh,
		unsigned char maxval) {

// clang-format off
    #pragma HLS INTERFACE m_axi     port=img_inp  offset=slave bundle=gmem1
    #pragma HLS INTERFACE m_axi     port=img_out  offset=slave bundle=gmem2
    #pragma HLS INTERFACE s_axilite port=rows              
    #pragma HLS INTERFACE s_axilite port=cols
    #pragma HLS INTERFACE s_axilite port=thresh              
    #pragma HLS INTERFACE s_axilite port=maxval 

//Defining Pragmas for lower and upper threshold values
    #pragma HLS INTERFACE m_axi port=lower_threshold   offset=slave  bundle=gmem3
    #pragma HLS INTERFACE m_axi port=upper_threshold   offset=slave  bundle=gmem4
              
    #pragma HLS INTERFACE s_axilite port=return
    // clang-format on


    xf::cv::Mat<TYPE, HEIGHT, WIDTH, NPC_T> in_mat(rows, cols);
// clang-format off
    #pragma HLS stream variable=in_mat.data depth=2
    // clang-format on

    xf::cv::Mat<TYPE, HEIGHT, WIDTH, NPC_T> hsv_mat(rows, cols);
// clang-format off
    #pragma HLS stream variable=hsv_mat.data depth=2
    // clang-format on

    xf::cv::Mat<OUT_TYPE, HEIGHT, WIDTH, NPC_T> inrange_mat(rows, cols);
//  clang-format off
    #pragma HLS stream variable=hsv_mat.data depth=2
    // clang-format on

	xf::cv::Mat<OUT_TYPE, HEIGHT, WIDTH, NPC_T> out_mat(rows, cols);
// clang-format off
    #pragma HLS stream variable=out_mat.data depth=2
// clang-format on

// clang-format off
    #pragma HLS DATAFLOW
    // clang-format on
    unsigned char local_low_thresh[3] = {0, 48, 80};
    unsigned char local_high_thresh[3] = {20,255,255};
	
    xf::cv::Array2xfMat<INPUT_PTR_WIDTH, TYPE, HEIGHT, WIDTH, NPC_T>(img_inp, in_mat);
    xf::cv::bgr2hsv<TYPE, HEIGHT, WIDTH, NPC_T>(in_mat, hsv_mat);
    xf::cv::inRange<TYPE, OUT_TYPE, HEIGHT, WIDTH, NPC_T>(hsv_mat, local_low_thresh, local_high_thresh, inrange_mat);
	xf::cv::Threshold<THRESH_TYPE, XF_8UC1, HEIGHT, WIDTH, NPC_T>(inrange_mat, out_mat, thresh, maxval);
    xf::cv::xfMat2Array<OUTPUT_PTR_WIDTH, OUT_TYPE, HEIGHT, WIDTH, NPC_T>(out_mat, img_out);
}
}

