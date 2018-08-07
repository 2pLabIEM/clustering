function mixPuta

clear all

prompt='for population vectors among stimuli enter 1. For a trial-by-trial plot enter 2. For side by side of two stimuli enter 3';
rozhodnutie=input(prompt);

if rozhodnutie==1

listOfNeurons=dir('neuron*.mat');
neuronsN=size(listOfNeurons,1);
load(listOfNeurons(1,1).name, 'PSTHindividual');
[a,b,c,d]=size(PSTHindividual);


timeBins=b; %10ms time bins - ISI 3000ms
repetitions=a;
stimuliN=d;
respStartBin=1;
respEndBin=50;
spontStartBin=b-(round(b/3));
spontEndBin=b;
%%%%%%%%%%%%%%%%%%%%%%%% Load data


PSTH4Dall=zeros(repetitions, timeBins, neuronsN, stimuliN);

for index=1:neuronsN
    load(listOfNeurons(index,1).name, 'PSTHindividual');
    PSTH4Dall(:,:,index,:)=PSTHindividual;
end

velke=mean(PSTH4Dall,1);
velke=squeeze(velke);
male=velke(1:25,:,:);
male=mean(male,1);
male=squeeze(male);


for n=1:d
    
meanResp=male(:,n);
spolu(:,n)=meanResp;
end

% % velke=mean(PSTH4Dall,1);
% % velke=squeeze(velke);
% % male=velke(1:25,:,:);
% % male=mean(male,1);
% % male=squeeze(male);
% jedna=male(:,1);
% dva=male(:,2);
% tri=male(:,3);
% styri=male(:,4);
% pat=male(:,5);
% sest=male(:,6);
% sedem=male(:,7);
% osem=male(:,8);
% devat=male(:,9);
% desat=male(:,10);
% jedenast=male(:,11);
% spolu(:,1)=jedna;
% spolu(:,2)=dva;
% spolu(:,3)=tri;
% spolu(:,4)=styri;
% spolu(:,5)=pat;
% spolu(:,6)=sest;
% spolu(:,7)=sedem;
% spolu(:,8)=osem;
% spolu(:,9)=devat;
% spolu(:,10)=desat;
% spolu(:,11)=jedenast;
figure
imagesc(spolu)
end

if rozhodnutie==2
    
prompt='vyber si cislo stimulu';
cislo_stimulu=input(prompt);
    
    listOfNeurons=dir('neuron*.mat');
neuronsN=size(listOfNeurons,1);
load(listOfNeurons(1,1).name, 'PSTHindividual');
[a,b,c,d]=size(PSTHindividual);


timeBins=b; %10ms time bins - ISI 3000ms
repetitions=a;
stimuliN=d;
respStartBin=1;
respEndBin=50;
spontStartBin=b-(round(b/3));
spontEndBin=b;
%%%%%%%%%%%%%%%%%%%%%%%% Load data


PSTH4Dall=zeros(repetitions, timeBins, neuronsN, stimuliN);

for index=1:neuronsN
    load(listOfNeurons(index,1).name, 'PSTHindividual');
    PSTH4Dall(:,:,index,:)=PSTHindividual;
end
    
velke=PSTH4Dall(:,:,:,cislo_stimulu);
velke=squeeze(velke);
male=velke(:,1:25,:);
male=mean(male,2);
male=squeeze(male);


for n=1:neuronsN
    
meanResp=male(:,n);
spolu(:,n)=meanResp;
end
spolu=spolu';
spolu*-1;
figure
imagesc(spolu)
end

if rozhodnutie==3

    listOfNeurons=dir('neuron*.mat');
neuronsN=size(listOfNeurons,1);
load(listOfNeurons(1,1).name, 'PSTHindividual');
[a,b,c,d]=size(PSTHindividual);


timeBins=b; %10ms time bins - ISI 3000ms
repetitions=a;
stimuliN=d;
respStartBin=1;
respEndBin=50;
spontStartBin=b-(round(b/3));
spontEndBin=b;
%%%%%%%%%%%%%%%%%%%%%%%% Load data


PSTH4Dall=zeros(repetitions, timeBins, neuronsN, stimuliN);

for index=1:neuronsN
    load(listOfNeurons(index,1).name, 'PSTHindividual');
    PSTH4Dall(:,:,index,:)=PSTHindividual;
end
   
prompt='stimul 1';
prvy=input(prompt);
prompt='stimul 2';
druhy=input(prompt);

velke=mean(PSTH4Dall,1);
velke=squeeze(velke);
male=velke(1:25,:,:);
male=mean(male,1);
male=squeeze(male);
jedna=male(:,prvy);
dva=male(:,druhy);
spolu(:,1)=jedna;
spolu(:,2)=dva;
figure
imagesc(spolu)
end