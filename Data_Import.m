%% Import ARKit3 Data and convert to 4x4 transformation matrix
% You can call i-th joint's transformation matrix at j-th time by calling
% Joint_Mat{j,i}, which returns 4x4 double array

% Input ARKit's raw data's column order must be as follows:
% 1st: Time
% 2nd: Hip Position
% 3rd: Hip Quaternion
% 4th~10th: spine_joints
% 11th: head_joint
% 12th~14th: right_arm/forearm/hand_joint
% 15th~17th: left_arm/forearm/hand_joint
% 18th~20th: right_upLeg/leg/foot_joint
% 21st~23rd: left_upLeg/leg/foot_joint

% Output Joint_Mat's column order is as follows:
% 1st~3rd: right_arm/forearm/hand_joint
% 4th~6th: left_arm/forearm/hand_joint
% 7th~9th: right_upLeg/leg/foot_joint
% 10th~12th: left_upLeg/leg/foot_joint

clear all; close all; clc;

Data = readtable('Presentation-Data.xlsx'); % Change the file name to whatever that contains ARKit data
Timestamps = table2array(Data(:,1));
Data = table2array(Data(:,12:end));

Joint_Mat = {};
for index = 1:numel(Data)
    rot_mat = Data{index};
    rot_mat = reshape(str2num(rot_mat(24:end-2)), [4,4]);
    Joint_Mat = [Joint_Mat rot_mat];
end
Joint_Mat = reshape(Joint_Mat, [size(Data, 1), size(Data, 2)]);