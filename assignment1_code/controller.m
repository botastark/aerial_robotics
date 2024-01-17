function [ u ] = pd_controller(~, s, s_des, params)
%PD_CONTROLLER  PD controller for the height
%
%   s: 2x1 vector containing the current state [z; v_z]
%   s_des: 2x1 vector containing desired state [z; v_z]
%   params: robot parameters
e = s_des(1)-s(1);

Kp = 80;
e_dot = s_des(2)-s(2);
Kv = 11;
z_dot_dot_des = 0;
u = params.mass*(params.gravity + z_dot_dot_des + Kp*e + Kv*e_dot);


% FILL IN YOUR CODE HERE


end

