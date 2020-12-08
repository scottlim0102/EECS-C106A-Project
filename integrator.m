function [x,y,z] = integrator(matrix, n)
    % Inputs:
    %   matrix: M x N x 4 x 4 vel, acc matrix
    %   n: The desired n_th joint
    
    % Outputs:
    %   x, y, z: The integrated component of the input matrix
    
    % Currently, just looking at translational part and neglecting
    % rotational part. We might need to address rotation.
    
    dx = squeeze(matrix(:,n,1,4));
    x = cumtrapz(dx);
    
    dy = squeeze(matrix(:,n,1,4));
    y = cumtrapz(dx);
    
    dz = squeeze(matrix(:,n,1,4));
    z = cumtrapz(dx);
    
end