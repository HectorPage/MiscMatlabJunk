function [inverse_quat] = inverse_quaternion(input_quat)
%This function takes and input quaternion and caulculates its inverse,
%which is defined as conjugate/magnitude. Input is a quaternion, output is
%the inverse of the input quaternion

%Details of quaternion maths can be found at:
%http://graphics.cs.williams.edu/courses/cs371/s07/reading/quaternions.pdf

%Created by Hector Page 24/09/15

%Input quat magnitude n(quat) = sqrt(quat.quat)
    sum = 0;
    for index=1:4
        sum = sum + (input_quat(index) * input_quat(index));
    end

    input_quat_magnitude = sqrt(sum); 

    %Input quat conjugate
    input_quat_conjugate = zeros(1,4);
    input_quat_conjugate(1) = input_quat(1);

    for index=2:4
        input_quat_conjugate(index) = -input_quat(index);
    end

    %Now using above to inverse rotation quaternion
    inverse_quat = zeros(1,4);
    
    for index=1:4
        inverse_quat(index) = input_quat_conjugate(index)/input_quat_magnitude;
    end

end

