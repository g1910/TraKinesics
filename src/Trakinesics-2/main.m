clc;
stoppreview(vid);
clear all
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%

pointer = Robot() ;
screenSize = get(0,'screensize') 

pause(3);
% imagein = imread('img_petals.jpg');

vid=videoinput('winvideo',1,'YUY2_320x240');
%  set(vid,'ReturnedColorSpace','rgb');

preview(vid);
%figure
%hold on
% hmedianfilt = vision.MedianFilter([5 5]);
hmedianfilt2 = vision.MedianFilter([10 10]);
figure;
hold on;
press = 0;
detection = 0;
drag = 0;
while 1
    frame = getsnapshot(vid);
    skin = findSkinYUY(frame);
    filtered = filterS(skin);
    filteredMs = step(hmedianfilt2, filtered);
%     filteredMs = imerode(filteredMs,strel('disk',4));
    [F Z]= detect(filteredMs);
%     F = imdilate(F,strel('disk',4));
    F = bwareaopen(F, 230);
    comp = bwconncomp(F);
    comp
    S = regionprops(comp,'Centroid')
    sizeS = size(S,1);
    c = [0 0];
    if sizeS == 0
        if press == 0 && detection == 1 && drag == 0
            press = 1;
            pointer.mousePress(InputEvent.BUTTON1_MASK) ;
            pointer.mouseRelease(InputEvent.BUTTON1_MASK) ;
            pointer.mousePress(InputEvent.BUTTON1_MASK) ;
        end
        drag = 1;
        detection = 0;
    else if sizeS<=2
            for i=1:sizeS
                c = c + S(i).Centroid;
            end
            c = c/sizeS
            if sizeS == 1
                if detection == 1
                    if drag == 0
                        pointer.mousePress(InputEvent.BUTTON1_MASK) ;
                        coord = c;
                        drag = 1;
                    else
                        newcoord = c;
                        diff(1) = (coord(1) - newcoord(1));
                        diff(2) = (newcoord(2)-coord(2));
                        diff
                        MouseMove(screenSize, pointer, diff);
                        coord = newcoord;
                    end
                end
            else
                if press == 1 || drag == 1
                    pointer.mouseRelease(InputEvent.BUTTON1_MASK) ;
                    press = 0;
                    drag = 0;
                end
                if detection==0
                    coord = c;
                    detection = 1;
                else
                    newcoord = c;
                    diff(1) = (coord(1) - newcoord(1));
                    diff(2) = (newcoord(2)-coord(2));
                    diff
                    MouseMove(screenSize, pointer, diff);
                    coord = newcoord;
                end
            end
            
        end
    end
    
%     if sizeS~=2
%         if sizeS==0 && press == 0
%             pointer.mousePress(InputEvent.BUTTON1_MASK) ;
%             press = 1;
%         end
%         detection = 0;
%     else if sizeS==2
%             if press == 1
%                 pointer.mouseRelease(InputEvent.BUTTON1_MASK) ;
%                 press = 0;
%             end
%             for i=1:sizeS
%                 c = c + S(i).Centroid;
%             end
%             c = c/sizeS
%             if detection==0
%                 coord = c;
%                 detection = 1;
%             else
%                 newcoord = c;
%                 diff(1) = (coord(1) - newcoord(1));
%                 diff(2) = (newcoord(2)-coord(2));
%                 diff
% %                 MouseMove(screenSize, pointer, diff);
%                 coord = newcoord;
%             end
%         end
%     end
        
%         MouseGoto(screenSize,pointer,c(1),c(2));
%     end
%     if press== 0 && sizeS == 0 
%         pointer.mousePress(InputEvent.BUTTON1_MASK) ;
%         press = 1;
%     end
%     if press == 1 && sizeS == 2
%          pointer.mouseRelease(InputEvent.BUTTON1_MASK) ;
%          press = 0;
%     end 
%     skinM = step(hmedianfilt, skin);
     
      
%      filteredM = filterS(skinM);
%       [Fs Z] = detect(skin);
      
%     filtered = filterS(fingers);
   
    subplot(2,2,1);
    imshow(skin);
    subplot(2,2,2);
    imshow(F);
    subplot(2,2,3);
     imshow(filteredMs);
%     subplot(2,2,4);
%     imshow(Fs);
    
    pause(0.2);
end