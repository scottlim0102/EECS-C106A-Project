function [x,y,z] = integrator(matrix, n)
    % Inputs:
    %   matrix: M x N x 4 x 4 vel, acc matrix
    %   n: The desired n_th joint
    
    % Outputs:
    %   x, y, z: The cumulative integrated component of the input matrix
    
    % Currently, just looking at translational part and neglecting
    % rotational part. We might need to address rotation also.
    % Also, we need to address the indexing (ex. Velocity has 931 data
    % points and cumtrapz produce 930 usable data, while position has 932
    % points) and constant.
    
    dx = squeeze(matrix(:,n,1,4));
    x = cumtrapz(dx);
    x = x * 16.67e-4; % Adjust from unit time(1sec) to actual interval(16.67ms)
    
    dy = squeeze(matrix(:,n,1,4));
    y = cumtrapz(dx);
    y = y * 16.67e-4; % Adjust from unit time(1sec) to actual interval(16.67ms)
    
    dz = squeeze(matrix(:,n,1,4));
    z = cumtrapz(dx);
    z = z * 16.67e-4; % Adjust from unit time(1sec) to actual interval(16.67ms)
    
end