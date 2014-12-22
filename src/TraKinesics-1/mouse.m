import java.awt.Robot ;

pointer = Robot() ;
screenSize = get(0,'screensize') 

% for i = 1: screenSize(4)
%       MouseGoto(pointer, i, i) ;
%       pause(0.00000001);
% end
% 
MouseLeftClick(pointer, screenSize(3)-90, 5) ;
pause(2) ;
MouseRightClick(pointer, screenSize(3)-90, 5) ;
pause(2) ;
for i=5:60
    MouseGoto(pointer, screenSize(3)-90, i) ;
    pause(0.00000001);
end

MouseLeftClick(pointer, screenSize(3)-90, i) ;