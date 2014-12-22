function [ im Z] = detect(imagein)

h1=fspecial('gaussian',[9 37],60);
h2=fspecial('gaussian',[9 37],60*1.414);

h3=h2-h1;


imagein = double(imagein);

Z = filter2(h3,imagein);

P = Z < -0.0021;
 
im = im2uint8(double(P)); 
%  im = imagein;
 


end

