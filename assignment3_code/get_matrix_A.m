function [grande_A] = get_matrix_A(n,Temp)

grande_A = zeros(8*n, 8*n);

for diag=1.0:1.0:n
    A_start = 8*(diag-1)+1;
    A_end = 8*diag;
    % grande_A(A_start:A_end,1:A_start-1)=zeros(8, 8*(diag-1));
    grande_A(A_start:A_end,A_start:A_end)=get_A(Temp(diag));
    % grande_A(A_start:A_end,A_end+1:8*n)=zeros(8, 8*(n-diag));
end
end