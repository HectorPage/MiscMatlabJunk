function quaternion_rotation(start_heading,end_heading)

%This function calculates resulting angle in rotation about gravitational axis 
%(zaxis), in the earth azimuthal (horizontal/yaw) plane for a given rotation
%in 3D space from start_heading to end_heading over 1 second. All rotations
%take place on a unit sphere.

%This function then performs Spherical Linear intERPolation (SLERP) to
%smoothly interpolate rotation in steps between the start and end.

%Input arguments are a start_heading and end_heading as normalised vectors
%(x,y,z) on a unit sphere. Also required is the number of spherical linear
%interpolation points (not including start and end quaternions) called
%slerpsteps.

%Details of quaternion maths can be found at:
%http://graphics.cs.williams.edu/courses/cs371/s07/reading/quaternions.pdf

%Created by Hector Page 24/09/15

 start_heading = start_heading/(norm(start_heading));
 end_heading = end_heading/(norm(end_heading));


%Calculating axis and angle of rotation
%See euler_rotation.m for details.
[rot_axis, rot_angle] = euler_rotation(start_heading,end_heading)
%rot_angle_degrees = rot_angle *(180/pi);

%Converting axis-angle representation to rotation quaternion
%See generate_rotation_quat.m for details
rotation_quat = generate_rotation_quat(rot_angle, rot_axis)

%Putting start_heading and end_heading in quaternion form
start_quat = zeros(1,4);
end_quat = zeros(1,4);
start_quat(2:4) = start_heading;
end_quat(2:4) = end_heading;

%From here on in, carrying out the quaternion rotation, where the rule is:
%resultant_quat = rotation_quat * start_quat * rotation_quat^-1

%Doing rotation quaternion * start quaternion here
%See multiply_quaternions.m for details.
intermediate_quat = multiply_quaternions(rotation_quat,start_quat);

%Caculating inverse of rotation quaternion (i.e. quat^-1)
%See inverse_quaternion.m for details.
inverse_rotation_quat = inverse_quaternion(rotation_quat);
    

%Now multiplying intermediate quaternion by inverse rotation quaternion to
%get resultant quaternion of rotation by the angle about the axis worked
%out Euler style. See multiply_quaternions.m for details.
resultant_quat = multiply_quaternions(intermediate_quat,inverse_rotation_quat);

% disp(resultant_quat); use this if you want to check that the resultant
% quat is correct


%THERE'S A PROBLEM WITH RESULTANT QUAT - ONE ELEMENT IS VERY SMALL, WHEN IT
%SHOULD BE ZERO! CHECK UP ON IT - LOOK AT ACCUMULATION OF ERROR THING ON
%CHROME BROWSERx


%Converting resultant quaternion back into vector format.
calculated_final_vector = resultant_quat(2:4)



figure();
quiver3(0,0,0,start_heading(1),start_heading(2),start_heading(3),'b');
hold on
quiver3(0,0,0,end_heading(1),end_heading(2),end_heading(3),'r');
quiver3(0,0,0,calculated_final_vector(1),calculated_final_vector(2),calculated_final_vector(3),'g');



% %Now comparing the azimuth angles of start_vector and
% %calculated_final_vector - this is rotation about gravitational axis
% [start_azimuth,~,~] = circular_coordinates(start_heading);
% [finish_azimuth,~,~] = circular_coordinates(calculated_final_vector);
% 
% disp(['Change in azimuth angle is: ', num2str((finish_azimuth-start_azimuth) *(180/pi)),' degrees']);
% 
% 
% %Now performing Spherical Linear intERPolation (SLERP)
% %see quaternion_slerp.m for more details
% 
% [~, vector_sequence, circstat_sequence] = quaternion_slerp(start_quat,resultant_quat,10,rot_angle);
% 
% %Now plotting interpolated direction vectors over time
% 
% %Providing origin of each vector
% origin = zeros(size(vector_sequence,1),3);
% 
% figure();
% quiver3(origin(:,1),origin(:,2),origin(:,3)...
%     ,vector_sequence(:,1),vector_sequence(:,2),vector_sequence(:,3),0);
% hold on;
% plot3(vector_sequence(:,1), vector_sequence(:,2), vector_sequence(:,3));
% grid on;
% view(-35,45);
% axis([-1 1 -1 1 -1 1]);
% 
% %Overlaying axes as vectors
% %Providing origin of the axes
% axes_origin = zeros(6,3);
% axes_vectors = [1,0,0;0,1,0;0,0,1;-1,0,0;0,-1,0;0,0,-1;];
% 
% quiver3(axes_origin(:,1),axes_origin(:,2),axes_origin(:,3)...
%     ,axes_vectors(:,1),axes_vectors(:,2),axes_vectors(:,3),0,'k');
% 
% 
% %Overlaying unit sphere to look nice/give context
% sphere_radius = 1;
% [sphere_x, sphere_y, sphere_z] = sphere(50);
% lightGrey = 0.9*[1 1 1]; % Making lines lighter, to not overwhelm vectors
% surface(sphere_x,sphere_y,sphere_z,'FaceColor', 'none','EdgeColor',lightGrey);
% 
% title(['Spherical Linear Interpolation from [',num2str(start_heading(1)),',',num2str(start_heading(2)),...
%     ',',num2str(start_heading(2)),'] to [', num2str(end_heading(1)),',',num2str(end_heading(2)),...
%     ',',num2str(end_heading(3)),']'],'Fontsize', 18);
% 
% set(gca,'Fontsize',18);
% 
% 
% %figure();
% %plot(circstat_sequence(1,:),'b');
% %hold on;
% %plot(circstat_sequence(3,:),'r');
% 
% 
% %TRYING TO GET POSITION AND HEADING HERE
% heading_sequence = zeros(size(vector_sequence,1),3);
% heading_sequence(:,1) = vector_sequence(:,3);
% heading_sequence(:,2) = vector_sequence(:,3);
% heading_sequence(:,3) = -(vector_sequence(:,1))-vector_sequence(:,2);
% 
% figure();
% quiver3(vector_sequence(:,1),vector_sequence(:,2),vector_sequence(:,3)...
%     ,heading_sequence(:,1),heading_sequence(:,2),heading_sequence(:,3),0);
% hold on;
% grid on;
% view(-35,45);
% axis([-1 1 -1 1 -1 1]);
% 
% %Overlaying axes as vectors
% %Providing origin of the axes
% axes_origin = zeros(6,3);
% axes_vectors = [1,0,0;0,1,0;0,0,1;-1,0,0;0,-1,0;0,0,-1;];
% 
% quiver3(axes_origin(:,1),axes_origin(:,2),axes_origin(:,3)...
%     ,axes_vectors(:,1),axes_vectors(:,2),axes_vectors(:,3),0,'k');
% 
% 
% %Overlaying unit sphere to look nice/give context
% sphere_radius = 1;
% [sphere_x, sphere_y, sphere_z] = sphere(50);
% lightGrey = 0.9*[1 1 1]; % Making lines lighter, to not overwhelm vectors
% surface(sphere_x,sphere_y,sphere_z,'FaceColor', 'none','EdgeColor',lightGrey);

end