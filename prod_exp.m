function T_matrix = prod_exp(xi, theta)   
   % Computes the product of exponentials for a kinematic chain, given 
   % the twists and displacements for each joint.
   % Args:
   % xi - (6, N) ndarray: the twists for each joint
   % theta - (N,) ndarray: the displacement of each joint
    
   % Returns:
   % T_matrix - (4,4) ndarray: the resulting homogeneous transformation matrix
   size_xi = size(xi);
   size_theta = size(theta);
    
   if  size_xi(1) ~= 6
       error('xi must be a 6xN')
   end
   if size_xi(2) ~= size_theta(2)
       error('there must be the same number of twists as joint angles.')
   end
   T_matrix = eye(4);
   for n = 1: size_xi(2)
       T_matrix = T_matrix * homog_3d(xi(:,n), theta(n));
   end