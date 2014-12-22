function [ GaussMask ] = MyGauss( Sigma, m, n )
%This function computes a Gaussian Mask with parameters Sigma and Size
    GaussMask = zeros(m,n);
    center = ceil([m n]./2);
    for i=1:m
        for j=1:n
            GaussMask(i,j) = exp(-(((i-center(1))^2)+((j-center(2))^2))/2/Sigma^2)/2/pi/Sigma^2;
        end
    end
    total = sum(GaussMask(:));
    GaussMask = GaussMask./total;
end
