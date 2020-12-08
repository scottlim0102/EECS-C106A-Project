function butter_mat = butterMat(Joint_Mat)
% Applies Butterworth filter to Joint_Mat
% Should output a filtered M timestamps x N joints cell array with 4 x 4
% transformation matrix entries.
    fo = 6;     % Order of the filter. Higher gives steeper cutoffs.
    fc = 3;     % Cutoff frequency in Hz
    fs = 60;    % Sample rate in Hz
    [b,a] = butter(fo,fc/(fs/2)); % [b,a] each of length = fo + 1
    mat_size = size(Joint_Mat);
    rotmats = cell(mat_size(1), mat_size(2));
    thetas = cell(mat_size(1), mat_size(2));
    vectors = cell(mat_size(1), mat_size(2));
    for j = 1:mat_size(2)
        for i = 1:mat_size(1)
            rotmats{i,j} = Joint_Mat{i,j}(1:3,1:3);
            thetas{i,j} = rotm2eul(rotmats{i,j});
            vectors{i,j} = Joint_Mat{i,j}(1:3,4);
        end
    end
    butter_thetas = filter(b,a,cell2mat(thetas));
    butter_vectors = filter(b,a,cell2mat(vectors));
    butter_rotmats = cell(mat_size(1), mat_size(2));
    butter_mat = cell(mat_size(1), mat_size(2));
    for j = 1:mat_size(2)
        for i = 1:mat_size(1)
            butter_rotmats{i,j} = eul2rotm(butter_thetas(i,3*j-2:3*j));
            butter_mat{i,j} = zeros(4,4);
            butter_mat{i,j}(1:3,1:3) = butter_rotmats{i,j};
            butter_mat{i,j}(1:3,4) = butter_vectors(i,j);
            butter_mat{i,j}(4,4) = 1;
        end
    end
    