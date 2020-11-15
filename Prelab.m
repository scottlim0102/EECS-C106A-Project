% -----------------------------3D Functions--------------------------------------
% -------------(These are the functions you need to complete)--------------------
syms one, two, three, four, five, six, seven, eight, nine, ten
function (one, two, three, four, five, six, seven, eight, nine, ten) = skew[theta1, theta2, theta3, theta4, theta5, theta6, theta7, theta8, theta9, theta10, theta11, theta12] 
%
 %theta1 : shoulder right
% theta2 : right elbow
% theta3 : right wrist
% theta4 : shoulder left
% theta5 : left elbow
% theta6 : left wrist
% theta7 : 
% theta8 :
 

%one = [x1, y1, z1]; 
%     Prelab Part (a)
% 
%     Converts a rotation vector in 3D to its corresponding skew-symmetric matrix.
%     
%     Args:
%     omega - (3,) ndarray: the rotation vector
%     
%     Returns:
%     omega_hat - (3,3) ndarray: the corresponding skew symmetric matrix

    if omega.shape ~= (3,):
        raise TypeError('omega must be a 3-vector')
    
    omega_hat = np.zeros((3,3))
    omega_hat[0,1] = -omega[2]
    omega_hat[1,0] = omega[2]
    omega_hat[0,2] = omega[1]
    omega_hat[2,0] = -omega[1]
    omega_hat[1,2] = -omega[0]
    omega_hat[2,1] = omega[0]

    return omega_hat

    % -- Rotation Start ---
    function rot = rotation_3d(omega, theta)

    % Computes a 3D rotation matrix given a rotation axis and angle of rotation.  
    % Args:
    % omega - 3x1 array: the axis of rotation
    % theta: the angle of rotation    
    % Returns:
    % rot - 3x3 array: the resulting rotation matrix
    
    if (size(omega) ~= [3 1])
        error('omega must be a 3-vector')
    end
    
    rot = eye(3) + skew(omega)/norm(omega)*sin(norm(omega)*theta) 
        + mtimes(skew(omega),skew(omega))/norm(omega).^2*(1-cos(norm(omega)*theta))
    
    end
    % -- Rotation End --
    
    % -- Hat Start -- 
    function xi_hat = hat_3d(xi)
    
    % Converts a 3D twist to its corresponding 4x4 matrix representation  
    % Args:
    % xi - 6x1 array: the 3D twist 
    % Returns:
    % xi_hat - 4x4 array: the corresponding 4x4 matrix
    
    if (size(xi) ~= [6 1])
        error('xi must be a 6-vector')
    end

    xi_hat = zeros(4)
    xi_hat(0:3,0:3) = skew(xi(3:6))
    xi_hat(0:3,3) = xi(0:3)
        
    end
    % -- Hat End --
    
    function g = homog_3d(xi, theta)
%     Prelab Part (d)
% 
%     Computes a 4x4 homogeneous transformation matrix given a 3D twist and a 
%     joint displacement.
%     
%     Args:
%     xi - (6,) ndarray: the 3D twist
%     theta: the joint displacement
%     Returns:
%     g - (4,4) ndarary: the resulting homogeneous transformation matrix
    if size(xi) ~= (1,6)
        error('xi must be a 6-vector')
    end
    
    v = xi(1:3);
    w = xi(4:end);
    I = eye(3);
    if (abs(w(1)) <= 1e-8) && (abs(w(2)) <= 1e-8) && (abs(w(3)) <= 1e-8) % Pure translation
        R = eye(3);
        p = v*theta;
    else % Translation and rotation
        R = rotation_3d(w, theta);
        p = 1/norm(w)^2*((eye(3)-rotation_3d(w, theta))*(skew_3d(w)*v) + ((w'*w)*v)*theta);
    g = eye(4);
    g(1:3, 1:3) = R;
    g(1:3, 4) = p;
    end
    end


def prod_exp(xi, theta):
    """
    Prelab Part (e)
    
    Computes the product of exponentials for a kinematic chain, given 
    the twists and displacements for each joint.
    
    Args:
    xi - (6, N) ndarray: the twists for each joint
    theta - (N,) ndarray: the displacement of each joint
    
    Returns:
    g - (4,4) ndarray: the resulting homogeneous transformation matrix
    """
    if not xi.shape[0] == 6:
        raise TypeError('xi must be a 6xN')
    if not xi.shape[1] == theta.shape[0]:
        raise TypeError('there must be the same number of twists as joint angles.')

    g = np.eye(4)
    for n in range(xi.shape[1]):
        g = np.matmul(g, homog_3d(xi[:,n], theta[n]))
    
    
    return g

#-----------------------------Testing code--------------------------------------
#-------------(you shouldn't need to modify anything below here)----------------

def array_func_test(func_name, args, ret_desired):
    ret_value = func_name(*args)
    if not isinstance(ret_value, np.ndarray):
        print('[FAIL] ' + func_name.__name__ + '() returned something other than a NumPy ndarray')
    elif ret_value.shape != ret_desired.shape:
        print('[FAIL] ' + func_name.__name__ + '() returned an ndarray with incorrect dimensions')
    elif not np.allclose(ret_value, ret_desired, rtol=1e-3):
        print('[FAIL] ' + func_name.__name__ + '() returned an incorrect value')
    else:
        print('[PASS] ' + func_name.__name__ + '() returned the correct value!')

if __name__ == "__main__":
    print('Testing...')

    #Test skew_3d()
    arg1 = np.array([1.0, 2, 3])
    func_args = (arg1,)
    ret_desired = np.array([[ 0., -3.,  2.],
                            [ 3., -0., -1.],
                            [-2.,  1.,  0.]])
    array_func_test(skew_3d, func_args, ret_desired)

    #Test rotation_3d()
    arg1 = np.array([2.0, 1, 3])
    arg2 = 0.587
    func_args = (arg1,arg2)
    ret_desired = np.array([[-0.1325, -0.4234,  0.8962],
                            [ 0.8765, -0.4723, -0.0935],
                            [ 0.4629,  0.7731,  0.4337]])
    array_func_test(rotation_3d, func_args, ret_desired)

    #Test hat_3d()
    arg1 = np.array([2.0, 1, 3, 5, 4, 2])
    func_args = (arg1,)
    ret_desired = np.array([[ 0., -2.,  4.,  2.],
                            [ 2., -0., -5.,  1.],
                            [-4.,  5.,  0.,  3.],
                            [ 0.,  0.,  0.,  0.]])
    array_func_test(hat_3d, func_args, ret_desired)

    #Test homog_3d()
    arg1 = np.array([2.0, 1, 3, 5, 4, 2])
    arg2 = 0.658
    func_args = (arg1,arg2)
    ret_desired = np.array([[ 0.4249,  0.8601, -0.2824,  1.7814],
                            [ 0.2901,  0.1661,  0.9425,  0.9643],
                            [ 0.8575, -0.4824, -0.179 ,  0.1978],
                            [ 0.    ,  0.    ,  0.    ,  1.    ]])
    array_func_test(homog_3d, func_args, ret_desired)

    #Test prod_exp()
    arg1 = np.array([[2.0, 1, 3, 5, 4, 6], [5, 3, 1, 1, 3, 2], [1, 3, 4, 5, 2, 4]]).T
    arg2 = np.array([0.658, 0.234, 1.345])
    func_args = (arg1,arg2)
    ret_desired = np.array([[ 0.4392,  0.4998,  0.7466,  7.6936],
                            [ 0.6599, -0.7434,  0.1095,  2.8849],
                            [ 0.6097,  0.4446, -0.6562,  3.3598],
                            [ 0.    ,  0.    ,  0.    ,  1.    ]])
    array_func_test(prod_exp, func_args, ret_desired)

    print('Done!')