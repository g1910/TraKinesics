function [ ImageConv  ] = MyConv( Image,Mask )
%This function performs Convolution between the Image and the Mask
    [m,n] = size(Mask);
    [h,k,l] = size(Image);
    Mask = Mask(m:-1:1,n:-1:1);
    ImageTemp = zeros(h+2*m-2,k+2*n-2,l,'uint8');
    ImageTemp(m:h+m-1,n:k+n-1,:)=Image;
    ImageConv = zeros(h+m-1,k+n-1,l,'uint8');
    q = repmat(Mask,[1,1,l]);
    for i=1:h+m-1
        for j=1:k+n-1
            ImageConv(i,j,:) = sum(sum(double(ImageTemp(i:i+m-1,j:j+n-1,:)).*q));
        end
    end
end

