function omega = rotation_to_omega(rotation_matrix, theta)
    % rotation_to_omega computes the omega axis associated with this
    % rotation-matrix and theta i.e in angle axis format using the formula
    % [R_32 - R_23; R_13 - R_31; R_21 - R_12]/ 2 sin(theta)
    R_32 = rotation_matrix(3, 2);
    R_23 = rotation_matrix(2, 3);
    R_13 = rotation_matrix(1, 3);
    R_31 = rotation_matrix(3, 1);
    R_21 = rotation_matrix(2, 1);
    R_12 = rotation_matrix(1, 2);
    R_list = [R_32 - R_23; R_13 - R_31; R_21 - R_12];

    omega = R_list/(2*sin(theta));