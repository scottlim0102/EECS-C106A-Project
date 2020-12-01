% This function computes the difference between the desired length and the
% experimental length, which is computed from 4x4 transformation matrices
% of two joints.

% Example call:
% length_checker(Joint_Mat{1,1}, Joint_Mat{1,2}, desired_length)
% It computes the difference between the right arm/forearm length at time 1
% and the desired_length.

function length_diff = length_checker(matrix1, matrix2, desired_length)
    if size(matrix1) ~= [4,4]
        error('First matrix is not a 4x4 transformation matrix');
    elseif size(matrix2) ~= [4,4]
        error('Second matrix is not a 4x4 transformation matrix');
    end
    
    length_diff = norm(matrix1(1:3, 4) - matrix2(1:3, 4)) - desired_length;
end