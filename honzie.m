mkdir Processed
list=dir('*tif');
example1=importdata(list(1,1).name);
red=example1(:,:,1);
green=example1(:,:,2);
blue=example1(:,:,3);

% select min + max for red
close all
imshow(red)
colormapeditor


prompt='min';
min=input(prompt);

prompt='max';
max=input(prompt);

limitsR=[min, max];


% select min + max for green
close all
imshow(green)
colormapeditor


prompt='min';
min=input(prompt);

prompt='max';
max=input(prompt);

limitsG=[min, max];

% select min + max for blue
close all
imshow(blue)
colormapeditor


prompt='min';
min=input(prompt);

prompt='max';
max=input(prompt);

limitsB=[min, max];

close all

list=dir('U2*');
[a,b]=size(list);

%for each of the images

mkdir Processed

for n=1:a
    
current=importdata(list(n,1).name);
red=current(:,:,1);
green=current(:,:,2);
blue=current(:,:,3);
%save with altered colormap

imshow(red)
caxis(limitsR);
saveas(gcf,'red.tif');
imshow(green)
caxis(limitsG);
saveas(gcf,'green.tif');
imshow(red)
caxis(limitsB);
saveas(gcf,'blue.tif');

%combine into a RGB masterstik

close all
imread('red.tif');
imread('green.tif');
imread('blue.tif');

red(:,:,2)=green(:,:,1);
red(:,:,3)=blue(:,:,1);
rgb=red;
rgb=mat2gray(rgb);
% filename=sprintf('image%d.tif',n); if image1,2,3,..,1000 is ok
filename=((list(n,1).name))
cd Processed
imwrite(rgb,filename)
imshow(rgb)
cd ../
end
delete('red.tif');
delete('green.tif');
delete('blue.tif');
close all
clear all

