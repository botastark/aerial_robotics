waypoints = [0    0   0;
              1    1   1;
              2    0   2;
              3    -1  1;
              4    0   0]';
[~, n] = size(waypoints);% number of waypoints
n = n-1;
T = ones(1, n);
s = [0, cumsum(T)];
w_x =  waypoints(1,:);
w_y =  waypoints(2,:);
w_z =  waypoints(3,:);


A = get_matrix_A(n,T);
b = [get_b(w_x,n) get_b(w_y,n) get_b(w_z,n)];

% disp(A);
% disp(b);
alpha = [A \ b(:,1), A \ b(:,2), A \ b(:,3)];

% disp(alpha);
% Hover
t=3.5;
T_end = s(end);
if t>T_end
    desired_state.pos =  waypoints(:,end);
    desired_state.vel = [0; 0; 0];
    desired_state.acc = [0; 0; 0];
    desired_state.yaw = 0;
    desired_state.yawdot = 0;
else
    if t>s(1) && t<s(2) %if i = 1
        i = 1;
    elseif t>s(2) && t<s(3) %if i = 2
        i = 2;
    elseif t>s(3) && t<s(4) %if i = 3
        i = 3;
    elseif t>s(4) && t<s(5) %if i = 4
        i = 4;
    else
        i = 5;
    end
    curr_alpha = alpha(8*(i-1)+1:8*i,:); %8x3
    prev_s = s(i);
    curr_T = T(i);
    temp = [((t-prev_s)/curr_T)^7, ((t-prev_s)/curr_T)^6,...
            ((t-prev_s)/curr_T)^5, ((t-prev_s)/curr_T)^4,...
            ((t-prev_s)/curr_T)^3, ((t-prev_s)/curr_T)^2,...
            (t-prev_s)/curr_T, 1];
  
    temp_d = 1/curr_T*[7*((t-prev_s)/curr_T)^6,...
            6*((t-prev_s)/curr_T)^5, 5*((t-prev_s)/curr_T)^4,...
            4*((t-prev_s)/curr_T)^3, 3*((t-prev_s)/curr_T)^2,...
            2*(t-prev_s)/curr_T, 1,0];
    temp_dd = 1/curr_T^2*[...
            7*6*((t-prev_s)/curr_T)^5, 6*5*((t-prev_s)/curr_T)^4,...
            5*4*((t-prev_s)/curr_T)^3, 4*3*((t-prev_s)/curr_T)^2,...
            3*2*(t-prev_s)/curr_T, 2,0,0];
    

    desired_state.pos = temp*curr_alpha;
    desired_state.vel = temp_d*curr_alpha;
    desired_state.acc = temp_dd*curr_alpha;
    desired_state.yaw = 0;
    desired_state.yawdot = 0;
end

    

% output desired state
% desired_state.pos = [pos; pos; pos];
% desired_state.vel = [vel; vel; vel];
% desired_state.acc = [acc; acc; acc];
% desired_state.yaw = pos;
% desired_state.yawdot = vel;

% polynomial = aa0+aa1*(t-s)/T + aa2*((t-s)/T)^2 +...
%         + aa3*((t-s)/T)^3 + aa4*((t-s)/T)^4 +...
%         + aa5*((t-s)/T)^5 + aa6*((t-s)/T)^6 +...
%         + aa7*((t-s)/T)^7;
