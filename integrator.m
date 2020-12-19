function [x,y,z] = integrator(matrix, n, to_plot, original)

    % Inputs:
    %   matrix: M x N x 4 x 4 vel, acc matrix
    %   n: The desired n_th joint
    %   to_plot: integer --> 1 to plot the x, y, z of the matrix, the
    %         integrated x, y, z, and the orginal, filtered data in 
    %         original, 0 for no plot
    %   original: The original filtered data to be compared to integrated
    %             output. M x N x 4 x 4 with positions or velocities.
    
    
    % Outputs:
    %   x, y, z: The cumulative integrated component of the input matrix
    
    % Currently, just looking at translational part and neglecting
    % rotational part. We might need to address rotation also.
    
    %x_change, y_change, z_change are values from the improper integral
    % i.e not adjusted with constants of integration
    
    dx = squeeze(matrix(:,n,1,4));
    x_change = cumtrapz(dx);
    x_change = x_change * 16.67e-4; % Adjust from unit time(1sec) to actual interval(16.67ms)
    
    dy = squeeze(matrix(:,n,2,4));
    y_change = cumtrapz(dy);
    y_change = y_change * 16.67e-4; % Adjust from unit time(1sec) to actual interval(16.67ms)
    
    dz = squeeze(matrix(:,n,3,4));
    z_change = cumtrapz(dz);
    z_change = z_change * 16.67e-4; % Adjust from unit time(1sec) to actual interval(16.67ms)
    
    %integration constants for each dimension
    x_iconstant = original{1, n}(1, 4);
    y_iconstant = original{1, n}(2, 4);
    z_iconstant = original{1, n} (3, 4);
    
    %final data
    x = x_change + x_iconstant;
    y = y_change + y_iconstant;
    z = z_change + z_iconstant;
    
    
    if to_plot == 1
        figure('Name', 'Integrated xyzzzzzzz')
        hold on
        title("Integrated xyz-data for joint " + n)
        plot(x,'--b')
        hold on
        plot(y, '-r')
        hold on
        plot(z, 'g')
        hold on
        xlabel('Sample number');
        ylabel('Joint Position (m)');
        legend(["x", "y", "z"])
        
        figure('Name', 'Unintegrated xyz')
        hold on
        title("Unintegrated xyz-data for joint " + n)
        hold on
        plot(matrix(:,n,1,4), "--b")
        hold on
        plot(matrix(:,n,2,4), "-r")
        hold on
        plot(matrix(:,n,3,4), "g")
        hold on
        legend("x", "y", "z")
        
    end    

        
end
