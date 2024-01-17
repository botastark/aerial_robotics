function [b] = get_b(w,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

b = zeros(8*n,1);
for iter=1.0:1.0:n
    b_start = 8*(iter-1)+1;
    b_end = 8*iter;
    % constrain 1: p_i(s_{i-1}) = w_{i-1}
    b(b_start:b_start+1) = w(iter:iter+1); %b1=w0, b2=w1, b9=w2, b10=w3... 
    % constrain 2: for i 1 and n: p_1^k(s_0) = p_n^k(s_n) = 0 with
    % k=1:3
    % these correspond to b3, b4, b5 for i=1 and i=n
    if iter == 1.0 || iter == n
        b(b_start+2:b_start+4)=[0,0,0]; %b3-b5=0,0,0; last =0,0,0
    else
        b(b_start+2:b_end)=[0,0,0,0,0,0]; %b11-b16=0,0,0,0,0,0;
    end

end

end