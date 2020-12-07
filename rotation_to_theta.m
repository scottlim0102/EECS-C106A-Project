function theta = rotation_to_theta(rotation_matrix)
    % rotation_to_theta computes the theta associated with this rotation_matrix
    % i.e in angle axis format using the formula theta = cos^-1((Tr(A)-1)/2))
    Tr = trace(rotation_matrix);
    theta = acos((Tr-1)/2) ;