%{
    Programmer: Sai Narayan
    Assessment: CMPEN 454 - Project 3
    Date:       5 August 2023
    File:       LucasKanade.m
    Professor:  Dr. Mohamed Almekkawy
%}

%% Lucas-Kanade affine image alignment method
function [u, v] = LucasKanadeRefactored(It, It1, rect)
    % Function to align two images using the Lucas-Kanade affine image alignment method
    % Input parameters: 
    %   It - initial image 
    %   It1 - subsequent image 
    %   rect - a rectangle specifying the region of the template in the initial image (given as [x, y, width, height])

    % Convert images to double precision
    % This is necessary for calculations involving decimal values
    ItD  = im2double(It);
    It1D = im2double(It1);

    % Extract template from the first image within given rectangle
    % The template is the target object we want to track in the image sequence
    temp = ItD(rect(1):rect(1)+rect(3)-1, rect(2):rect(2)+rect(4)-1);

    % Initialize parameters
    % Parameters correspond to an affine transformation that aligns the template with the image in the next frame
    p = zeros(6,1);
    deltaP = p+1;

    % Calculate image gradient in X and Y direction
    % This is used later in the algorithm to calculate the error between the template and the warped image
    [gX,gY] = imgradientxy(It1D);

    cnt = 0; % Counter for iterations

    % Iteratively update parameters while change is above a threshold or maximum iteration limit is not reached
    while (norm(deltaP)>1) && (cnt<=5)
        cnt = cnt + 1; % Increase iteration count

        % Create warp matrix W from parameters
        % This matrix is used to deform the subsequent image to match the template
        W = [1 + p(1), p(3), p(5); p(2), 1 + p(4), p(6); 0, 0, 1];

        %% Warp the second image with W and crop it to the size of the template
        It1DW = warpH(It1D, W, size(It1D));
        CrpIt1DW = It1DW(rect(1):rect(1)+rect(3)-1, rect(2):rect(2)+rect(4)-1);

        % Calculate difference between the template and the warped image
        % This error guides the adjustment of parameters in the next iteration
        error = temp - CrpIt1DW;

        % Warp the gradient images with W and crop them
        gXW = warpH(gX, W, size(It1D));
        CrpgXW = gXW(rect(1):rect(1)+rect(3)-1, rect(2):rect(2)+rect(4)-1);
        gYW = warpH(gY, W, size(It1D));
        CrpgYW = gYW(rect(1):rect(1)+rect(3)-1, rect(2):rect(2)+rect(4)-1);

        %% Get jacobian matrix
        jbn = getJacobian(rect(3), rect(4));

        % Compute Jacobian-weighted derivative
        % These are partial derivatives of the error with respect to parameters
        dI_dw_x = CrpgXW(:) .* jbn(:,:,1);
        dI_dw_y = CrpgYW(:) .* jbn(:,:,2);

        % Steepest descent images
        A = dI_dw_x + dI_dw_y;

        %% Hessian matrix
        % This matrix represents the curvature of the error surface and is used to adjust the parameters in the direction of steepest descent
        H = A' * A;

        % Compute parameter updates
        % Update is obtained by moving in the direction of steepest descent scaled by the inverse of the Hessian
        deltaP = H\(A' * error(:));
        p = p + deltaP;

        % Display current iteration and norm(deltaP)
        % Norm(deltaP) gives the magnitude of parameter update, it should decrease with iterations
        disp(['Iteration: ', num2str(cnt), ', Norm(deltaP): ', num2str(norm(deltaP))]);
    end

    % Return translation parameters
    % The last two parameters correspond to translation in x and y direction
    u = p(5);
    v = p(6);
end

%% Function to calculate the Jacobian matrix

function jacobian = getJacobian(w, h)
    % Function to compute the Jacobian matrix given the width and height of the template
    [x, y] = meshgrid(1:w, 1:h);
    x = x(:);
    y = y(:);
    zeroVec = zeros(numel(x), 1);
    oneVec = ones(numel(x), 1);
    jacobian = cat(3, [x, zeroVec, y, zeroVec, oneVec, zeroVec], [zeroVec, x, zeroVec, y, zeroVec, oneVec]);
end
