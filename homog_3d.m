function g = homog_3d(xi, theta)
    % Computes a 4x4 homogeneous transformation matrix given a 3D twist and a 
    % joint displacement.  
    % Args:
    % xi - (6,1) ndarray: the 3D twist
    % theta: the joint displacement
    % Returns:
    % g - (4,4) ndarary: the resulting homogeneous transformation matrix
    if size(xi) ~= 6 
        error('xi must be a 6-vector')
    end
    
    v = xi(1:3);
    w = xi(4:end);
    I = eye(3);
    if (abs(w(1)) <= 1e-8) && (abs(w(2)) <= 1e-8) && (abs(w(3)) <= 1e-8) % Pure translation
        R = I;
        p = v*theta;
    else % Translation and rotation
        R = rotation_3d(w, theta);
        p = 1/norm(w)^2.*((I-rotation_3d(w, theta))*(skew_3d(w)*v) + ((w*w')*v).*theta);
    end 
    g = eye(4);
    g(1:3, 1:3) = R;
    g(1:3, 4) = p;