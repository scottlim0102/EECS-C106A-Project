function parenthood_map = parenthoodMap()
    % Hard-coded parenthood dictionary for the given arrangement of joints
    % Use to obtain relative positions, velocities, accelerations, etc
    % Inputs:
    %   None, but based on current definition of Joint_Mat
    % Outputs:
    %   Map object with joint's column index from Joint_Mat as key, 
    %   parent joint's column index as value
    parenthood_mat = [1, 0;
                      2, 1;
                      3, 2;
                      4, 0;
                      5, 4;
                      6, 5;
                      7, 0;
                      8, 7;
                      9, 8;
                      10, 0;
                      11, 10;
                      12, 11;];
                  
    key_list = parenthood_mat(:,1);
    val_list = parenthood_mat(:,2);
                      
    parenthood_map = containers.Map(key_list, val_list);
    