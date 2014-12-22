function [skin] = findSkinYUY(I)
    S = size(I);
    skin = zeros(S(1),S(2));
 Cb = I(:,:,2);
 Cr = I(:,:,3);
    [x,y,z] = find(Cr>=131 & Cr <=185 & Cb>=80 & Cb<=135);
%      [x,y,z] = find(Cr>=133 & Cr <=173 & Cb>=80 & Cb<=120);
    p = size(x,1);
    for k=1:p
        skin(x(k),y(k)) = 255;
    end
end