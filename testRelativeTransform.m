translation1 = [0, 1, 0].';
axang1 = [1, 0, 0, pi/2];
rotation1 = [0,-1, 0;
             1, 0, 0;
             0, 0, 1];
transformation1 = zeros(4,4);
transformation1(1:3,1:3) = rotation1;
transformation1(1:3,4) = translation1;
transformation1(4,4) = 1;
transformation1

translation2 = [0, 0, 0].';
axang2 = [0, 1, 0, pi/2];
rotation2 = [0, -1, 0;
             1, 0, 0;
             0, 0,  1;];
transformation2 = zeros(4,4);
transformation2(1:3,1:3) = rotation2;
transformation2(1:3,4) = translation2;
transformation2(4,4) = 1;
transformation2

relativeTransform(transformation1, transformation2)