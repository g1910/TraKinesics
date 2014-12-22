function [ F ] = filterS( skin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
       
       skin = imdilate(skin,strel('disk',3));
       skin = bwareaopen(skin, 15);
%      skin = imdilate(skin,strel('line',40,90));
    F = skin;

end

