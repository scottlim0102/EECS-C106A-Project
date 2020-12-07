function omega_hat = skew_3d(omega) 
    % Converts a rotation vector in 3D to its corresponding skew-symmetric matrix.
    % Args:
    % omega - (3,) ndarray: the rotation vector
    % Returns:
    % omega_hat - (3,3) ndarray: the corresponding skew symmetric matrix  
    if (size(omega) ~= 3)
        error('omega must be a 3-vector')
    end 
    omega_hat = zeros(3,3);
    omega_hat(1, 2) = -omega(3);
    omega_hat(2, 1) = omega(3);
    omega_hat(1, 3) = omega(2);
    omega_hat(3, 1) = -omega(2);
    omega_hat(2, 3) = -omega(1);
    omega_hat(3, 2) = omega(1);
