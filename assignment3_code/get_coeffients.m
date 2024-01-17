function [A_alpha] = get_coeffients()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    syms T s t
    syms aa0 aa1 aa2 aa3 aa4 aa5 aa6 aa7
    syms A_alpha [8 8] 
    polynomial = aa0+aa1*(t-s)/T + aa2*((t-s)/T)^2 +...
        + aa3*((t-s)/T)^3 + aa4*((t-s)/T)^4 +...
        + aa5*((t-s)/T)^5 + aa6*((t-s)/T)^6 +...
        + aa7*((t-s)/T)^7;

    pk = polynomial;
    
    a = [aa0, aa1, aa2, aa3, aa4, aa5, aa6, aa7];
    for k=2.0:1.0:8.0
        if k==2.0
            pk_s1 = subs(pk, t=s);
            [coeffs_pk_s0, terms_pk_s0] = coeffs(pk_s1, a);
            len = size(terms_pk_s0);
            start_id = 8-len(2);
            A_alpha(1,1:start_id)=zeros(1,start_id);
            A_alpha(1,start_id+1:8)=coeffs_pk_s0;
        else
            pk = diff(pk,1);
        end
    
        pk_s = subs(pk, [t,s],[T,0]);
        [coeffs_pk, terms_pk] = coeffs(pk_s, a);
        len = size(terms_pk);
        A_alpha(k,1:len(2))=flip(coeffs_pk);
        A_alpha(k,len(2)+1:8)=zeros(1,8-len(2));
    disp(A_alpha);
    end
    

end