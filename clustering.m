function clustering

clear all

prompt='enter autocorr Thr ';
thrRepro=input(prompt);

listOfNeurons=dir('neuron*.mat');
neuronsN=size(listOfNeurons,1);
load(listOfNeurons(1,1).name, 'PSTHindividual');
[a,b,c,d]=size(PSTHindividual);


timeBins=b; %10ms time bins - ISI 3000ms
repetitions=a;
stimuliN=d;
respStartBin=1;
respEndBin=25;
spontStartBin=b-(round(b/3));
spontEndBin=b;
%%%%%%%%%%%%%%%%%%%%%%%% Load data


PSTH4Dall=zeros(repetitions, timeBins, neuronsN, stimuliN);

for index=1:neuronsN
    load(listOfNeurons(index,1).name, 'PSTHindividual');
    PSTH4Dall(:,:,index,:)=PSTHindividual;
end

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% Create Single trial population vectors for all
%%%%%%%%%%%%%%%%%%%%%%%% stimuli
resp=squeeze(mean(PSTH4Dall(:,respStartBin:respEndBin, :, :),2));
spont=squeeze(mean(PSTH4Dall(:,spontStartBin:spontEndBin, :, :),2));
respC=resp-spont;

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Create Average correlation matrix
ACM=zeros(stimuliN);
for stim1=1:stimuliN
    for stim2=1:stimuliN
        meanCorr=0;
        for rep1=1:repetitions
            for rep2=1:repetitions
                CM=corrcoef(squeeze(respC(rep1,:,stim1)),squeeze(respC(rep2,:,stim2)));
                if isnan(CM(1,1)) || isnan(CM(1,2))
                    CM(:,:)=0;
                end
                meanCorr=meanCorr+CM(1,2);

            end
        end
        ACM(stim1, stim2)=meanCorr/(repetitions*repetitions);
    end
end
%%%%%%%%%%diagonal
for stim1=1:stimuliN
        meanCorr=0;
        for rep1=1:repetitions
            for rep2=rep1+1:repetitions
                CM=corrcoef(squeeze(respC(rep1,:,stim1)),squeeze(respC(rep2,:,stim1)));
                if isnan(CM(1,1)) || isnan(CM(1,2))
                    CM(:,:)=0;
                end
                meanCorr=meanCorr+CM(1,2);

            end
        end
        ACM(stim1, stim1)=2*meanCorr/(repetitions*(repetitions-1));

end
%%%%%%%%%%%%%%%%%%%%%%%%

%thrRepro=0.1;
x=diag(ACM);
tbd=find(x<thrRepro);
survivals=find(x>thrRepro);
ACMcheck=ACM;
ACM(:,tbd)=[];
ACM(tbd, :)=[];
if size(ACM, 1)<2
    disp('Too few thresholded stimuli')
  return;
end
imagesc(ACM)
colormap jet
figure

ACMtree=1-ACM;
Z = linkage(ACMtree, 'ward');
[H,T,outperm] =dendrogram(Z, size(ACM, 1));
figure

ACMclust=ACM(outperm, :);
ACMclust=ACMclust(:,outperm);
imagesc(ACMclust)
colormap jet
%%%%%%%%%%%survivals are those thresholded stimuli and outperm is their
%%%%%%%%%%%order in the produced clustered matrix



%%%%%Searching for clusters that fulfill the condition, that if Cii<Cij or
%%%%%Cjj<Cij then i and j belong to same cluster

maxModN=10;
stimuliN=size(ACM,1);
haltSearch=0;
for modN=2:maxModN
T = cluster(Z,'maxclust',modN);
for sD=1:stimuliN
for sND=1:stimuliN
if ACM(sD, sD)<ACM(sD, sND)
   if T(sD)~=T(sND)
       haltSearch=1;
       break;
   end


end
end
if haltSearch==1
    break;
end
end
if haltSearch==1
    break;
end
end
modN=modN-1;
disp('clusters found');
disp(modN);
T = cluster(Z,'maxclust',modN);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 if d==39


if modN==1
    cluster1=find(T==1);
    origStimIdentC1=survivals(cluster1);
    disp('1mod- cisla z Complex74');
disp(origStimIdentC1);
end

if modN==2
cluster1=find(T==1);
cluster2=find(T==2);

origStimIdentC1=survivals(cluster1);
origStimIdentC2=survivals(cluster2);
disp('2 mody - cisla z Complex74');
disp(origStimIdentC1);
disp(origStimIdentC2);
end

if modN==3
cluster1=find(T==1);
cluster2=find(T==2);
cluster3=find(T==3);

origStimIdentC1=survivals(cluster1);
origStimIdentC2=survivals(cluster2);
origStimIdentC3=survivals(cluster3);
disp('3 mody - cisla z Complex74');
disp(origStimIdentC1);
disp(origStimIdentC2);
disp(origStimIdentC3);
end

if modN==4
cluster1=find(T==1);
cluster2=find(T==2);
cluster3=find(T==3);
cluster4=find(T==4);

origStimIdentC1=survivals(cluster1);
origStimIdentC2=survivals(cluster2);
origStimIdentC3=survivals(cluster3);
origStimIdentC4=survivals(cluster4);

disp('4 mody - cisla z Complex74');
disp(origStimIdentC1);
disp(origStimIdentC2);
disp(origStimIdentC3);
disp(origStimIdentC4);
end

 else

 if modN==2
cluster1=find(T==1);
cluster2=find(T==2);

C1=survivals(cluster1);
C2=survivals(cluster2);
disp('2 mody - cisla z mixu');
disp(C1);
disp(C2);
end

if modN==3
cluster1=find(T==1);
cluster2=find(T==2);
cluster3=find(T==3);

C1=survivals(cluster1);
C2=survivals(cluster2);
C3=survivals(cluster3);
disp('3 mody - cisla z mixu');
disp(C1);
disp(C2);
disp(C3);
end
 end

%%%%%%%%%%%%%%%%%%%modul na vizualizaciu identit neuronov v klastroch

% prompt='stimul 1';
% prvy=input(prompt);
% prompt='stimul 2';
% druhy=input(prompt);
%
% velke=mean(PSTH4Dall,1);
% velke=squeeze(velke);
% male=velke(1:25,:,:);
% male=mean(male,1);
% male=squeeze(male);
% jedna=male(:,prvy);
% dva=male(:,druhy);
% spolu(:,1)=jedna;
% spolu(:,2)=dva;
% figure
% imagesc(spolu)

%%%%%%%%%%%%%%%%%%%%%%%%modul na identifikaciu stimulov pri pouziti baseTHR_corr matice

% load('baseTHR_corr.mat');
% load('C:\funkce\20161027\TwoPhotonProcessor\Complex74_2.mat');
% [a,b]=size(base);
% [c,d]=size(baseTHR_corr);
% v(1,39)=zeros;
% for n=2:a-1
%     for m=2:c-1
%        if base(n,:)==baseTHR_corr(m,:)
%            v(1,n-1)=n-1;
%        end
%
%     end
% end
% v(v==0)=[]
%
% v=v';
% save('q.mat') %hlavne na troubleshooting vsetky variables
%
% [a,b]=size(C1);
%
% for n=1:a
% S1(n,1)=v((C1(n,1)),1)
% end
%
% [a,b]=size(C2);
%
% for n=1:a
%     S2(n,:)=v((C2(n,1)),1);
% end
% S2
% if modN==3
% [a,b]=size(C3)
%
% for n=1:a
% S3(n,1)=v((C3(n,1)),1)
% end
% end
