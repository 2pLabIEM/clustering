function popResponse

% clear all

listOfNeurons=dir('neuron*.mat');
neuronsN=size(listOfNeurons,1);
load(listOfNeurons(1,1).name, 'PSTHindividual');
[a,b,c,d]=size(PSTHindividual);


timeBins=b; %10ms time bins - ISI 3000ms
repetitions=a;
stimuliN=d;
respStartBin=2;
respEndBin=25;
spontStartBin=b-(round(b/3));
spontEndBin=b;
%%%%%%%%%%%%%%%%%%%%%%%% Load data

PSTH4Dall=zeros(repetitions, timeBins, neuronsN, stimuliN);

for index=1:neuronsN
    load(listOfNeurons(index,1).name, 'PSTHindividual');
    PSTH4Dall(:,:,index,:)=PSTHindividual;
end

PSTH4Dall=PSTH4Dall(:,1:25,:,:);

if d==39
meanP=mean(PSTH4Dall);
meanP=squeeze(meanP);
meanP=mean(meanP);
meanP=squeeze(meanP);
pop=mean(meanP);
figure
plot(pop)
imagesc(pop)

else
meanP=mean(PSTH4Dall);
meanP=squeeze(meanP);
meanP=mean(meanP);
meanP=squeeze(meanP);
pop=mean(meanP);
popG=pop(:,1:11);
figure
imagesc(popG)
% plot(pop)
end
