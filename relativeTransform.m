function relative_transform = relativeTransform(target_transform, reference_transform)
    % Finds the relative_transform matrix from reference_transform to target_transform
    % Should work for positions, velocities, accelerations, etc.
    % Inputs:
    %   target_transform: 4x4 transformation matrix
    %   reference_transform: 4x4 transformation matrix
    % Outputs:
    %   relative_transform: 4x4 transformation matrix
    translation = target_transform(1:3,4) - reference_transform(1:3,4);
    inv_reference_rotation = (reference_transform(1:3,1:3)).';
    target_rotation = target_transform(1:3,1:3);
    relative_rotation = target_rotation * inv_reference_rotation;
    relative_transform = zeros(4,4);
    relative_transform(1:3,1:3) = relative_rotation;
    relative_transform(1:3,4) = inv_reference_rotation * translation;
    relative_transform(4,4) = 1;