% This function extracts the Euler angles from a list of calculated
% rotation matrices, and stores them into a dictionary with their
% corresponding joint angle names.

% Args:
%  rotmat - list of rotation matrices of all the angles in the order: 
%    "right_arm_joint", "right_forearm_joint", "right_hand_joint"
%    "left_arm_joint", "left_forearm_joint", "left_hand_joint", 
%    "right_upLeg_joint", "right_leg_joint", "right_foot_joint", 
%    "left_upLeg_joint", "left_leg_joint", "left_foot_joint"
% Returns:
%  thetas - dictionary of the euler angles with their corresponding joint
%  names

% To access the value of a certain joint angle, use:
%    angle_value = thetas('joint_angle_name')

function thetas = theta_dictionary(rotmat)
    thetas = containers.Map();
    thetas('right_arm_joint') = rot2eul(rotmat(0)); 
    thetas('right_forearm_joint') = rot2eul(rotmat(1)); 
    thetas('right_hand_joint') = rot2eul(rotmat(2)); 
    thetas('left_arm_joint') = rot2eul(rotmat(3)); 
    thetas('left_forearm_joint') = rot2eul(rotmat(4)); 
    thetas('left_hand_joint') = rot2eul(rotmat(5)); 
    thetas('right_upLeg_joint') = rot2eul(rotmat(6)); 
    thetas('right_leg_joint') = rot2eul(rotmat(7)); 
    thetas('right_foot_joint') = rot2eul(rotmat(8)); 
    thetas('left_upLeg_joint') = rot2eul(rotmat(9)); 
    thetas('left_leg_joint') = rot2eul(rotmat(10)); 
    thetas('left_foot_joint') = rot2eul(rotmat(11)); 
end