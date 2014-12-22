function ImageConv = MyConv (ImageIn, Mask) 
    [P Q] = size(Mask) ;
    [M N, Dim] = size(ImageIn) ;
    Mask = Mask(P:-1:1, Q:-1:1) ;
    
    ImageIn = vertcat(zeros(P-1,N, Dim), ImageIn, zeros(P-1,N, Dim) ) ;

    [m,n] = size(ImageIn) ;
    
    ImageIn = horzcat(zeros(m,Q-1) , ImageIn, zeros(m,Q-1) ) ;
%     [J,K] = size(ImageIn) ;
    ImageConv = zeros(M+P-1, N-Q+1) ;
    
    for k=1:Dim
        for m=1:M+P-1
            for n=1:N+Q-1
                temp = (double(ImageIn(m:m+P-1,n:n+Q-1, k) ) .* Mask) ;
                ImageConv(m,n, k) = sum(sum(temp, 1), 2) ;
            end
        end
    end
    
    % Keeping the dimensions of the image matrix to be same
    ImageConv = ImageConv(floor(P/2)+1:floor(P/2)+M, floor(Q/2)+1:floor(Q/2)+N, 1:Dim) ;       

end