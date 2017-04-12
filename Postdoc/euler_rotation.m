function [rot_axis, rot_angle] = euler_rotation(start_heading,end_heading)
%This function takes a start vector, and a final vector, and calculates the
%axis and angle of rotation between them. Input should be given as (x,y,z) coordinates.
%The angle is returned in radians. For more info google: "euler rotations".
%A tan-based rule (rather than usual acos) to get angle, as is more stable%

%Created by Hector Page 24/09/15%


rot_angle = atan2(norm(cross(start_heading,end_heading)), dot(start_heading,end_heading));
rot_axis = cross(end_heading,start_heading); 

%N.B. in the above, be aware of cross product direction
% i.e. order of end_heading and start_heading is important for CP
% direction...
end

