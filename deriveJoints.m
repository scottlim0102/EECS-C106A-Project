function [derivative, out] = deriveJoints(matrix, timestamps)
    % Obtains instantaneous derivative of matrix columns by timestamps
    % Likely requires some additional smoothing
    % Inputs:
    %   matrix, an M x N x 4 x 4 matrix of pos, vel, acc, etc vectors
    %   timestamps, an M x 1 matrix of times in ms
    % Outputs:
    %   der, the derivative calculated from the input matrix
    time_diff = diff(timestamps,1,1);
    matrix_size = size(matrix);
    matrix_diff = zeros(matrix_size(1) - 1, matrix_size(2), 4, 4);
    derivative = zeros(matrix_size(1) - 1, matrix_size(2), 4, 4);
    for j = 1:matrix_size(2)
        for i = 1:matrix_size(1) - 1
            this_mat = squeeze(matrix(i,j,:,:));
            next_mat = squeeze(matrix(i+1,j,:,:));
            if iscell(this_mat)
                this_mat = cell2mat(this_mat);
                next_mat = cell2mat(next_mat);
            end
            matrix_diff(i,j,:,:) = relativeTransform(next_mat, this_mat);
        end
    end
    for j = 1:matrix_size(2)
        for i = 1:matrix_size(1) - 1
            this_diff = squeeze(matrix_diff(i,j,:,:));
            derivative(i,j,:,:) = real(mpower(this_diff, (1000/time_diff(i))));
        end
    end
    out = zeros(4,4,matrix_size(1) - 1);
    for i = 1:matrix_size(1) - 1
        size(squeeze(matrix_diff(i,1,:,:)))
        out(:,:,i) = squeeze(matrix_diff(i,3,:,:));
    end
    