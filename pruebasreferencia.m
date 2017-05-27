close all; clear all; clc;

X=[1, 2, 3; 4, 5, 6; 7, 8, 9]
[n,m]=size(X);
 
for i=1:1:n
    for j=1:1:(m)
        fprintf('%.2f ',X(i,j));
    end
        fprintf('\n');    
end
    
    