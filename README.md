# Embedded Security (SS21) Project Proposal: Hand Gesture Detector (From Images not videos) 

> Tabdar Khan (@tb15228), Siraj Munir (@sm11293)


## Overview

We want to build algorithm to **detect hand gestures from images** using `software` and then accelerating the algorithm using `PYNQ-Z2 FPGA board`.

## Background

We have often seen the use of computer vision to Recognize gestures in different videos and we must admit it looks pretty cool. Based on our research, we know that most of that work is done using `Machine Learning` or `Computer Vision`.

We will be using the Computer vision's `Image processing` approach as the time allotted for project does not allow for the machine learning solutions. For this purpose, the one thing that is used extensively used is the **[OpenCV-Python](https://docs.opencv.org/3.4/index.html)** library.

We want to detect hand gestures listed below:
* **1 Finger** -> Representing **1**
* **2 Fingers** -> Representing **2**
* **3 Fingers** -> Representing **3**
* **4 Fingers** -> Representing **4**
* **5 Fingers** -> Representing **5**
* **Thumbs Up** -> Representing **OK!**
* More gestures may be added (if time allows) 


## Implementation Strategy

Our Project falls into three major categories:
* Firstly in software using `Python` and `OpenCV`, 
* Implementing the algorithm using the `PYNQ-Z2 FPGA board`
* Finally comparing the time of both the Implementations

First, we will implement the project in our **Software Part**. We will be using image processing techniques in `OpenCV` library and `Python` and our priority is to make an algorithm where the use of the built-in `OpenCV` functions is as minimal as possible. We will be implementing all the steps mentioned in the tasks below using this approach. 

Secondly, We will implement the same algorithm in `PYNQ-Z2 FPGA Board` and this will be our **Hardware Approach**. We will built necessary `IPs` and `Overlays` where needed to facilitate to acceleration.

Finally, once both of the systems are running and giving round about the same outputs, we will measure and compare the execution of both the approaches using `timeit` library.

## Tasks

1. Uploading a picture into the program
2. Segmenting hand region from a picture
3. Background subtraction
4. Thresholding
5. Contouring
6. Give the appropriate output based on contour defects

The above tasks are to be implemented in **Software** using `OpenCV` and `Python` as well as on **Hardware** using`PYNQ-Z2 board`


### Estimated Timeline

* **Task 1** (hours to be decided) - both
* **Task 2** (hours to be decided) - both
* **Task 3** (hours to be decided) - both
* **Task 4** (hours to be decided) - both
* **Task 5** (hours to be decided) - both


## References

1. [OpenCV Documentation for Python](https://docs.opencv.org/3.4/index.html) 
2. [Xilinx documentation on using ZYNQ-7000 with OpenCV](https://www.xilinx.com/support/documentation/application_notes/xapp1167.pdf)
