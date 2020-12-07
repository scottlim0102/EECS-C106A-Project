 function xi = xi_finder(omega, position) 
    % xi_finder computes the xi given the omega axis of angle-axis rotation 
    % and the position of any point on omega axis.
    xi = [cross(-omega, position); omega];