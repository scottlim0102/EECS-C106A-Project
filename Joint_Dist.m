row = size(Joint_Mat,1);
col = size(Joint_Mat,2);

Distance = zeros(row,col-1);

for j = [1:col-1]
    for i = [1:row]
        mat1 = Joint_Mat{i,j};
        mat2 = Joint_Mat{i,j+1};
        
        pos1 = mat1(1:3, 4);
        pos2 = mat2(1:3, 4);
        Distance(i,j) = norm(pos1-pos2);
    end
end

