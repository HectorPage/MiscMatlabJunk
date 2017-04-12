function [azimuth,elevation,radius] = circular_coordinates(input_vector)
%This function returns to azimuth, elevation and radius and an (x,y,z)
%coordinate in 3D space. Angles are returned in radians.

%Created by Hector Page 24/09/15

azimuth = atan2(input_vector(2),input_vector(1));
radius = sqrt(input_vector(1)^2 + input_vector(2)^2 + input_vector(3)^2);
elevation = acos(input_vector(3)/radius);

end

