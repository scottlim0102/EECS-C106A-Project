%% Test skew_3d()
print('Testing skew_3d')
arg1 = [1.0, 2, 3];
ret_desired = [[ 0., -3.,  2.],
    [ 3., -0., -1.],
    [-2.,  1.,  0.]];
if skew_3d(arg1) == ret_desired
    print('Passed!')
else
    print('Failed')
end

%% Test rotation_3d()
print('Testing skew_3d')
arg1 = [2.0, 1, 3];
arg2 = 0.587;
ret_desired = [[-0.1325, -0.4234,  0.8962],
    [ 0.8765, -0.4723, -0.0935],
    [ 0.4629,  0.7731,  0.4337]];
if rotation_3d(arg1, arg2) == ret_desired
    print('Passed!')
else
    print('Failed')
end

%% Test hat_3d()
arg1 = [2.0, 1, 3, 5, 4, 2];
ret_desired = [[ 0., -2.,  4.,  2.],
    [ 2., -0., -5.,  1.],
    [-4.,  5.,  0.,  3.],
    [ 0.,  0.,  0.,  0.]];
if hat_3d(arg1) == ret_desired
    print('Passed!')
else
    print('Failed')
end

%% Test homog_3d()
arg1 = [2.0, 1, 3, 5, 4, 2];
arg2 = 0.658;
ret_desired = [[ 0.4249,  0.8601, -0.2824,  1.7814],
    [ 0.2901,  0.1661,  0.9425,  0.9643],
    [ 0.8575, -0.4824, -0.179 ,  0.1978],
    [ 0.    ,  0.    ,  0.    ,  1.    ]];
if homog_3d(arg1, arg2) == ret_desired
    print('Passed!')
else
    print('Failed')
end

%% Test prod_exp()
arg1 = [[2.0, 1, 3, 5, 4, 6],
    [5, 3, 1, 1, 3, 2],
    [1, 3, 4, 5, 2, 4]]';
arg2 = [0.658, 0.234, 1.345];
ret_desired = [[ 0.4392,  0.4998,  0.7466,  7.6936],
    [ 0.6599, -0.7434,  0.1095,  2.8849],
    [ 0.6097,  0.4446, -0.6562,  3.3598],
    [ 0.    ,  0.    ,  0.    ,  1.    ]];
if prod_exp(arg1, arg2) == ret_desired
    print('Passed!')
else
    print('Failed')
end

%% Test 2D case of left arm
% I assumed gst0 is with arms hanging straight down.
% Thus, the desired g should be the same as gst0 for left arm
clear all; clc;

gst0 = [[1, 0, 0, 0],
    [0, 1, 0, -0.153],
    [0, 0, 1, 0.129],
    [0, 0, 0, 1]];

xi1 = [-skew_3d([1, 0, 0])*[0, 0.288, 0.129], [1, 0, 0]];
xi2 = [-skew_3d([1, 0, 0])*[0, 0.1, 0.129], [1, 0, 0]];
xi3 = [-skew_3d([1, 0, 0])*[0, -0.045, 0.129], [1, 0, 0]];
xi_array = [xi1,
    xi2,
    xi3]';

theta = [0, 0, 0];

g_desired = [[1, 0, 0, 0],
    [0, 1, 0, -0.153],
    [0, 0, 1, 0.129],
    [0, 0, 0, 1]];
if prod_exp(xi_array, theta)*gst0 == g_desired
    print('Passed!')
else
    print('Failed')
end

%% Test 2D case of right arm
% The right arm is 90 deg raised
clear all; clc;

gst0 = [[1, 0, 0, 0],
    [0, 1, 0, -0.153],
    [0, 0, 1, -0.129],
    [0, 0, 0, 1]];

xi1 = [-skew_3d([1, 0, 0])*[0, 0.288, -0.129], [1, 0, 0]];
xi2 = [-skew_3d([1, 0, 0])*[0, 0.1, -0.129], [1, 0, 0]];
xi3 = [-skew_3d([1, 0, 0])*[0, -0.045, -0.129], [1, 0, 0]];
xi_array = [xi1,
    xi2,
    xi3]';

theta = [pi/2, 0, 0];

g_desired = [[1, 0, 0, 0],
    [0, 0, -1, 0.288],
    [0, 1, 0, -0.569],
    [0, 0, 0, 1]];
if prod_exp(xi_array, theta)*gst0 == g_desired
    print('Passed!')
else
    print('Failed')
end

%% Test 2D case of right leg
clear all; clc;

gst0 = [[1, 0, 0, 0],
    [0, 1, 0, -0.53],
    [0, 0, 1, -0.095],
    [0, 0, 0, 1]];

xi1 = [-skew_3d([1, 0, 0])*[0, 0, -0.095], [1, 0, 0]];
xi2 = [-skew_3d([1, 0, 0])*[0, -0.245, -0.095], [1, 0, 0]];
xi3 = [-skew_3d([1, 0, 0])*[0, -0.491, -0.095], [1, 0, 0]];
xi_array = [xi1,
    xi2,
    xi3]';

theta = [0, 0, 0];

g_desired = [[1, 0, 0, 0],
    [0, 1, 0, -0.53],
    [0, 0, 1, -0.095],
    [0, 0, 0, 1]];
if prod_exp(xi_array, theta)*gst0 == g_desired
    print('Passed!')
else
    print('Failed')
end