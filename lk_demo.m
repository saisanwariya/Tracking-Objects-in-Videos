%{
    Programmer: Sai Narayan
    Assessment: CMPEN 454 - Project 3
    Date:       5 August 2023
    File:       ik_demo.m
    Professor:  Dr. Mohamed Almekkawy

%}

clc, clear, close all

% Define the initial position of the bounding box for the tracker
tracker = [160, 120, 300,260];

% Initialize the video writer object and specify the output video file
video = VideoWriter('../results/car.mp4');
open(video); % Open the video file

% Calculate the width and height of the bounding box
width = abs(tracker(1)-tracker(3));
height = abs(tracker(2)-tracker(4));

% TODO: Define your own bounding box in the format [x y w h] 
% Hint: Use ginput function to interactively select the pixel coordinates on an image

% Create a new figure window
figure;

% Read the initial image frame
prev_frame = imread('../data/car/frame0020.jpg');

% Loop through image frames 20 to 200
for i = 20:200
    % Read the previous frame
    prev_frame = imread(sprintf('../data/car/frame%04d.jpg', i));

    % Read the new frame
    new_frame = imread(sprintf('../data/car/frame%04d.jpg', i+1));
    
    % Calculate the width and height of the bounding box for the new frame
    width = abs(tracker(1)-tracker(3));
    height = abs(tracker(2)-tracker(4));

    % Display the previous frame
    imshow(prev_frame);
    hold on; % Keep the current plot active
    
    % Draw a rectangle (bounding box) on the image
    rectangle('Position',[tracker(1),tracker(2),width,height], 'LineWidth',3, 'EdgeColor', 'y');
    
    hold off; % Release the current plot
    pause(0.1); % Pause the execution for 0.1 second to display each frame
    
    % Capture the current figure window as an image
    F = getframe;
    
    % Write the captured frame to the video file
    writeVideo(video,F);
    
    % Define the rectangle for the Lucas-Kanade tracker
    rect = [tracker(1),tracker(2),width,height];
    
    % Apply the Lucas-Kanade method to compute the displacement between the previous and new frame
    [u,v] = LucasKanade(prev_frame,new_frame,rect);
    
    % Update the position of the bounding box with the computed displacement
    tracker(1) = round(tracker(1)+u);
    tracker(2) = round(tracker(2)+v);
    tracker(3) = round(tracker(3)+u);
    tracker(4) = round(tracker(4)+v);
end

% Close the video file
close(video)
