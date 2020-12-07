function rot = rotation_3d(omega, theta) 
    % Computes a 3D rotation matrix given a rotation axis and angle of rotation.
    % Args:
    % omega - 3x1 array: the axis of rotation
    % theta: the angle of rotation    
    % Returns:
    % rot - 3x3 array: the resulting rotation matrix 
    if (size(omega) ~= 3)
        error('omega must be a 3-vector')
    end
    omega_hat = skew_3d(omega);
    omega_hat_square = omega_hat * omega_hat;
    omega_norm = norm(omega);
    omega_norm_square = omega_norm * omega * norm;
    omega_sin = sin(omega_norm * theta);
    omega_cos = cos(omega_norm * theta);
    rot = eye(3) + (omega_hat / omega_norm) * omega_sin  + (omega_hat_square / omega_norm_square) * (1 - omega_cos);
