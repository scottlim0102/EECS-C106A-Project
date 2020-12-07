% Documentation
% The data flow is as follows:
% the thetas given correspond to x, y, z rotations of each joint. From
% these thetas, the appropriate Rotation matrices are obtained, then the 
% equivalent Rot-final matrix is obtained, which is used to calculate 
% the omega axis about which the rotation is carried out. Since we know the
% final rotation matrix, we can also calculate theta-final about the omega
% axis. Omega and theta-final are used to calculate the xi axes about each
% joint. Then the exponential map is produced for each group of joints and 
% the positions are found. These positions are then compared to the
% positions obtained from the ARKit and returned if closer than the error
% to the actual positions. Otherwise, a different set of angles is used. 
