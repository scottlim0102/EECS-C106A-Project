function rotation_final = theta_to_rotation(joint_thetas)
    % theta_to_rotation computes the rotation matrix from 
    theta_x = joint_thetas(1);
    theta_y = joint_thetas(2);
    theta_z = joint_thetas(3);

    R_x = [1 0 0; 0 cos(theta_x) -sin(theta_x); 0 sin(theta_x) cos(theta_x)];
	R_y = [cos(theta_y) 0 sin(theta_y); 0 1 0; -sin(theta_y) 0 cos(theta_y)];
    R_z = [cos(theta_z) -sin(theta_z) 0; sin(theta_z) cos(theta_z) 0; 0 0 1];

    rotation_final = R_z*R_y*R_x;