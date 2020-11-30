%% Import ARKit3 Data and convert to 4x4 transformation matrix
% You can call i-th joint's transformation matrix at j-th time by calling
% Joint_Mat{j,i}, which returns 4x4 double array
clear all; close all; clc;

Data = readtable('11.28.20-CSV.xlsx'); % Change the file name to whatever that contains ARKit data
Data = table2array(Data(:,2:end));

Joint_Mat = {};
for index = 1:numel(Data)
    rot_mat = Data{index};
    rot_mat = reshape(str2num(rot_mat(24:end-2)), [4,4]);
    Joint_Mat = [Joint_Mat rot_mat];
end
Joint_Mat = reshape(Joint_Mat, [size(Data, 1), size(Data, 2)]);