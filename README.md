# Embedded Security (SS21) Final Project: Hand Gesture Detector (From Images not videos) 

> Tabdar Khan (@tb15228), Siraj Munir (@sm11293)


## Overview

We have impemented initial algorithms to **detect hand gestures from images** using `software` and then accelerating the algorithm using `PYNQ-Z2 FPGA board` using `Vitis Vision Libraries`.

### Software Approach
![PS](images/readme_image.PNG)
### Programmable Logic Approach
![PL](images/readme_image2.PNG)
## Challenges
We had to stop at skin masking step in the PL logic because **Vitis Vision Libraries** do not support finding and drawing contours yet.

## Steps to run
```sh
1. make
```


### Estimated Timeline

* **Task 1** (hours to be decided) - both
* **Task 2** (hours to be decided) - both
* **Task 3** (hours to be decided) - both
* **Task 4** (hours to be decided) - both
* **Task 5** (hours to be decided) - both


## References

1. [OpenCV Documentation for Python](https://docs.opencv.org/3.4/index.html) 
2. [Xilinx documentation on using ZYNQ-7000 with OpenCV](https://www.xilinx.com/support/documentation/application_notes/xapp1167.pdf)
