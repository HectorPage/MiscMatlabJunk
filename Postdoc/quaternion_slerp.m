function [quat_sequence, vector_sequence, circstat_sequence] = ...
    quaternion_slerp(start_quat,end_quat, slerpsteps, rot_angle)
%This function performs Spherical Linear intERPolation (SLERP) between
%start_quat and end_quat, separated by rot_angle (in radians), in equally 
%spaced points over a period of 1 second as defined by slerpsteps. It 
%returns a sequence of quaternions, a sequence of vectors, and a sequence 
%of their associated circular coordinates (in radians)

%Details of quaternion maths, including SLERP, can be found at:
%http://graphics.cs.williams.edu/courses/cs371/s07/reading/quaternions.pdf

%Created by Hector Page 24/09/15

slerp_interval = 1/slerpsteps;

slerptimes = 0:slerp_interval:1;

quat_sequence = zeros((slerpsteps+1),4); %this holds the interpolated quat sequence

for index=1:slerpsteps
    quat_sequence(index,:) = ((start_quat*sin((1-slerptimes(index))*(rot_angle/2)))...
      + (end_quat * sin(slerptimes(index)*(rot_angle/2))))/sin(rot_angle/2);    
end

quat_sequence(slerpsteps+1,:) = end_quat;

%Next step: convert quat_sequence to a sequence of vectors, and then a
%sequence of azimuth, elevation, and radius

vector_sequence = quat_sequence(:,2:4);

azimuth_sequence = zeros(1,slerpsteps+1);
radius_sequence = zeros(1,slerpsteps+1);
elevation_sequence = zeros(1,slerpsteps+1);

for index=1:(slerpsteps+1)
    azimuth_sequence(index) = (atan2(vector_sequence(index,2),vector_sequence(index,1))) * (180/pi);
    radius_sequence(index) = sqrt(vector_sequence(index,1)^2 + vector_sequence(index,2)^2 + vector_sequence(index,3)^2);
    elevation_sequence(index) =  (acos(vector_sequence(index,3)/radius_sequence(index))) * (180/pi);
end

circstat_sequence = zeros(3,numel(azimuth_sequence));

circstat_sequence(1,:) = azimuth_sequence;
circstat_sequence(2,:) = radius_sequence;
circstat_sequence(3,:) = elevation_sequence;

end

