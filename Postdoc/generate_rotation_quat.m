function [rotation_quat] = generate_rotation_quat(rot_angle,rot_axis)
%This function generates a rotation quaternion from an eueler axis and
%angle of rotation.

%Created by Hector Page 24/09/15

rotation_quat = zeros(1,4);
rotation_quat(1) = cos(rot_angle/2);
rotation_quat(2:4) = (sin(rot_angle/2)) * rot_axis;


end

