<h1 align="center">Object Tracking with Lucas-Kanade and Matthew-Baker Methods</h1>

## Overview

The Lucas-Kanade tracker, and then a more computationally efficient version called the Matthew-Baker (or inverse compositional) method. This method is one of the most commonly used methods in computer vision due to its simplicity and wide applicability.

To initialize the tracker you need to define a template by drawing a bounding box around the object to be tracked in the first frame of the video. For each of the subsequent frames, the tracker will update an affine transform that warps the current frame so that the template in the first frame is aligned with the warped current frame.

## Program Functionality
This project includes implementations of two object tracking methods: Lucas-Kanade and Matthew-Baker. Lucas-Kanade uses a forward additive alignment approach, while Matthew-Baker employs an inverse compositional alignment method. The project allows you to track an object in a video by specifying a template in the first frame.

## Software Setup
Before running the program, ensure you have the following software and libraries installed:

- MATLAB (R2019b or later)

## Running the Program
1. Clone the repository to your local machine.
2. Open MATLAB.
3. Navigate to the project directory.
4. Run the provided script files `lk_demo.m` and `mb_demo.m` to test the Lucas-Kanade and Matthew-Baker trackers, respectively. These scripts handle reading in images, template region marking, making tracker function calls, and displaying the output on the screen.
5. Follow the on-screen instructions to specify the initial bounding box for tracking.
6. Observe the tracking results in MATLAB's figure windows.

## Notes
- For tracking a patch template, the summation is performed only over the pixels lying inside the template region.
- You can adjust parameters and initialization coordinates to improve tracking performance.
- The provided video sequences are for testing purposes. You can replace them with your own videos for object tracking.

# Academic Integrity Statement:
Please note that all work included in this project is the original work of the author, and any external sources or references have been properly cited and credited. It is strictly prohibited to copy, reproduce, or use any part of this work without permission from the author.

If you choose to use any part of this work as a reference or resource, you are responsible for ensuring that you do not plagiarize or violate any academic integrity policies or guidelines. The author of this work cannot be held liable for any legal or academic consequences resulting from the misuse or misappropriation of this work.

Any unauthorized copying or use of this work may result in serious consequences, including but not limited to academic penalties, legal action, and damage to personal and professional reputation. Therefore, please use this work only as a reference and always ensure that you properly cite and attribute any sources or references used.

---
