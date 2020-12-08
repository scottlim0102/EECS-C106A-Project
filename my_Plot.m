function a = my_Plot(matrix, n)
% Inputs:
%   matrix: M x N x 4 x 4 pos/vel/acc etc matrix
%   n: Desired n-th joint

% Outputs:
%   Plot the n-th joint's translational pos/vel/acc

% Ex) my_Plot(butter_acc, 1)

val = [];
for i = 1:size(matrix, 1)
    val = [val, norm(squeeze(matrix(i,n,1:3,4)))];
end

figure();
plot(1:size(matrix,1), val);
a = [];

end