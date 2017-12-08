clc
clear all
close all

I1 = imread('toys.jpg');
I2 = imread('toy1.jpg');
I3 = imread('toy2.jpg');
I4 = imread('toy3.jpg');

Ipts1 = OpenSurf(I1);
Ipts2 = OpenSurf(I2);
Ipts3 = OpenSurf(I3);
Ipts4 = OpenSurf(I4);

BaseLength = length(Ipts1);
SubLength1 = length(Ipts2);
SubLength2 = length(Ipts3);
SubLength3 = length(Ipts4);

for k = 1:BaseLength
    D1(:,k) = Ipts1(k).descriptor;
end

for k = 1:SubLength1
    D2(:,k) = Ipts2(k).descriptor;
end

for k = 1:SubLength2
    D3(:,k) = Ipts3(k).descriptor;
end

for k = 1:SubLength3
    D4(:,k) = Ipts4(k).descriptor;
end

for i = 1:BaseLength
    subtract1 = (repmat(D1(:,i), [1, SubLength1]) - D2).^2;
    distance1 = sum(subtract1);
    [SubValue1(i), SubIndex1(i)] = min(distance1);
    
    subtract2 = (repmat(D1(:,i), [1, SubLength2]) - D3).^2;
    distance2 = sum(subtract2);
    [SubValue2(i), SubIndex2(i)] = min(distance2);
    
    subtract3 = (repmat(D1(:,i), [1, SubLength3]) - D4).^2;
    distance3 = sum(subtract3);
    [SubValue3(i), SubIndex3(i)] = min(distance3);
end

[value1, index1] = sort(SubValue1);
[value2, index2] = sort(SubValue2);
[value3, index3] = sort(SubValue3);

index1 = index1(1:9);
index2 = index2(1:10);
index3 = index3(1:10);

BaseIndex1 = index1;
SubIndex1 = SubIndex1(index1);
BaseIndex2 = index2;
SubIndex2 = SubIndex2(index2);
BaseIndex3 = index3;
SubIndex3 = SubIndex3(index3);

Pos1_1 = [ [Ipts1(BaseIndex1).y]',[Ipts1(BaseIndex1).x]'];
Pos2_1 = [ [Ipts2(SubIndex1).y]',[Ipts2(SubIndex1).x]'];

Pos1_2 = [ [Ipts1(BaseIndex2).y]',[Ipts1(BaseIndex2).x]'];
Pos2_2 = [ [Ipts3(SubIndex2).y]',[Ipts3(SubIndex2).x]'];

Pos1_3 = [ [Ipts1(BaseIndex3).y]',[Ipts1(BaseIndex3).x]'];
Pos2_3 = [ [Ipts4(SubIndex3).y]',[Ipts4(SubIndex3).x]'];

I_1 = cat(2,I1,I2);
I_2 = cat(2,I1,I3);
I_3 = cat(2,I1,I4);

figure
imshow(I_1)
hold on
plot( [Pos1_1(:,2) Pos2_1(:,2)+size(I1,2)]', [Pos1_1(:,1) Pos2_1(:,1)]', 's-', 'linewidth',2);

figure(2)
imshow(I_2)
hold on
plot( [Pos1_2(:,2) Pos2_2(:,2)+size(I1,2)]', [Pos1_2(:,1) Pos2_2(:,1)]', 's-', 'linewidth',2);

figure(3)
imshow(I_3)
hold on
plot( [Pos1_3(:,2) Pos2_3(:,2)+size(I1,2)]', [Pos1_3(:,1) Pos2_3(:,1)]', 's-', 'linewidth',2);
