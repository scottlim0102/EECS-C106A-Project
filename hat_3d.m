function xi_hat = hat_3d(xi)
    % Converts a 3D twist to its corresponding 4x4 matrix representation  
    % Args:
    % xi - 6x1 array: the 3D twist 
    % Returns:
    % xi_hat - 4x4 array: the corresponding 4x4 matrix
    if (size(omega) ~= 6)
        error('omega must be a 6-vector')
    end
    xi_hat = zeros(4);
    xi_hat(0:3,0:3) = skew_3d(xi(3:6));
    xi_hat(0:3,3) = xi(0:3);