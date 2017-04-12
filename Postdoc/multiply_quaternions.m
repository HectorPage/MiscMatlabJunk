function [resultant_quat] = multiply_quaternions(first_quat,second_quat)
%This function mutiplies two quaternions. Be carefuly - quaternion
%multiplication is non-commutative. This function calculates
%first_quat*second_quat

%Input arguments are two quaternions, output is a third quaternion, which
%is the result of their multiplication.

%Details of quaternion maths can be found at:
%http://graphics.cs.williams.edu/courses/cs371/s07/reading/quaternions.pdf

%Created by Hector Page 24/09/15

resultant_quat = zeros(1,4);


resultant_quat(1) = (first_quat(1) * second_quat(1)) - (first_quat(2) * second_quat(2))...
                       - (first_quat(3) * second_quat(3)) - (first_quat(4) * second_quat(4));
                   
resultant_quat(2) = (first_quat(1) * second_quat(2)) + (first_quat(2) * second_quat(1))...
                       - (first_quat(3) * second_quat(4)) + (first_quat(4) * second_quat(3));
                   
resultant_quat(3) = (first_quat(1) * second_quat(3)) + (first_quat(2) * second_quat(4))...
                       + (first_quat(3) * second_quat(1)) - (first_quat(4) * second_quat(2));  
                   
resultant_quat(4) = (first_quat(1) * second_quat(4)) - (first_quat(2) * second_quat(3))...
                       + (first_quat(3) * second_quat(2)) + (first_quat(4) * second_quat(1));


end

