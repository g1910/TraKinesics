function MouseMove( screenSize, pointer, diff )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    location = get(0,'PointerLocation');
    x = location(1)+(diff(1)*screenSize(3)/320)
    y = screenSize(4)-  location(2)+(diff(2)*screenSize(4)/240)
    
    pointer.mouseMove(x,y);

end

