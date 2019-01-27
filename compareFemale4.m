function compareFemale

clear all

selpath1=uigetdir('O:\Filip\7f','session1');
selpath2=uigetdir('O:\Filip\7f','session2'); 

%%

%prvy sesh

cd(selpath1)

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


PSTH4Dall1=zeros(repetitions, timeBins, neuronsN, stimuliN);

for index=1:neuronsN
    load(listOfNeurons(index,1).name, 'PSTHindividual');
    PSTH4Dall1(:,:,index,:)=PSTHindividual;
end

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% Create Single trial population vectors for all
%%%%%%%%%%%%%%%%%%%%%%%% stimuli
resp=squeeze(mean(PSTH4Dall1(:,respStartBin:respEndBin, :, :),2));
spont=squeeze(mean(PSTH4Dall1(:,spontStartBin:spontEndBin, :, :),2));
respC1=resp-spont;

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Create Average correlation matrix
ACM=zeros(stimuliN);
for stim1=1:stimuliN
    for stim2=1:stimuliN
        meanCorr=0;
        for rep1=1:repetitions
            for rep2=1:repetitions
                CM=corrcoef(squeeze(respC1(rep1,:,stim1)),squeeze(respC1(rep2,:,stim2)));
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
                CM=corrcoef(squeeze(respC1(rep1,:,stim1)),squeeze(respC1(rep2,:,stim1)));
                if isnan(CM(1,1)) || isnan(CM(1,2))
                    CM(:,:)=0;
                end
                meanCorr=meanCorr+CM(1,2);
                
            end
        end
        ACM(stim1, stim1)=2*meanCorr/(repetitions*(repetitions-1));

end


thrRepro=0.05;
x1=diag(ACM);
tbd=find(x1<thrRepro);
survivals1=find(x1>thrRepro);

%%
%druhy sesh

cd(selpath2)

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


PSTH4Dall2=zeros(repetitions, timeBins, neuronsN, stimuliN);

for index=1:neuronsN
    load(listOfNeurons(index,1).name, 'PSTHindividual');
    PSTH4Dall2(:,:,index,:)=PSTHindividual;
end

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% Create Single trial population vectors for all
%%%%%%%%%%%%%%%%%%%%%%%% stimuli
resp=squeeze(mean(PSTH4Dall2(:,respStartBin:respEndBin, :, :),2));
spont=squeeze(mean(PSTH4Dall2(:,spontStartBin:spontEndBin, :, :),2));
respC2=resp-spont;

%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% Create Average correlation matrix
ACM=zeros(stimuliN);
for stim1=1:stimuliN
    for stim2=1:stimuliN
        meanCorr=0;
        for rep1=1:repetitions
            for rep2=1:repetitions
                CM=corrcoef(squeeze(respC2(rep1,:,stim1)),squeeze(respC2(rep2,:,stim2)));
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
                CM=corrcoef(squeeze(respC2(rep1,:,stim1)),squeeze(respC2(rep2,:,stim1)));
                if isnan(CM(1,1)) || isnan(CM(1,2))
                    CM(:,:)=0;
                end
                meanCorr=meanCorr+CM(1,2);
                
            end
        end
        ACM(stim1, stim1)=2*meanCorr/(repetitions*(repetitions-1));

end


thrRepro=0.1;
x2=diag(ACM);
tbd2=find(x2<thrRepro);
survivals2=find(x2>thrRepro);

%%

[navyse1,pozicia1]=setdiff(survivals1,survivals2);
[navyse2,pozicia2]=setdiff(survivals2,survivals1);
FinalSurvivals=survivals1;
FinalSurvivals(pozicia1)=[];

ITcorrCoefsInfo(size(FinalSurvivals),2)=zeros;

%pre prvu sesh

for q=1:(size(FinalSurvivals))
    
        ITcorrCoefsInfo(q,1)=x1((FinalSurvivals(q,:)));
end

%pre druhu sesh

for q=1:(size(FinalSurvivals))
    
        ITcorrCoefsInfo(q,2)=x2((FinalSurvivals(q,:)));
end

%% medzisesh porovnavania



ACM=zeros(stimuliN);
for stim1=1:stimuliN
    for stim2=1:stimuliN
        meanCorr=0;
        for rep1=1:repetitions
            for rep2=1:repetitions
                CM=corrcoef(squeeze(respC1(rep1,:,stim1)),squeeze(respC2(rep2,:,stim2)));
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
                CM=corrcoef(squeeze(respC1(rep1,:,stim1)),squeeze(respC2(rep2,:,stim1)));
                if isnan(CM(1,1)) || isnan(CM(1,2))
                    CM(:,:)=0;
                end
                meanCorr=meanCorr+CM(1,2);
                
            end
        end
        ACM(stim1, stim1)=2*meanCorr/(repetitions*(repetitions-1));

end


thrRepro=0.1;
x3=diag(ACM);
tbd3=find(x3<thrRepro);
survivals3=find(x3>thrRepro);

%vymazat stimuly co sice su podobne medzi sessions ale neboli dost podobne
%medzi trials

[s,d]=setdiff(survivals3,FinalSurvivals);

for index=1:(size(d))
    
    survivals3(d(index))=0;
end
survivals3(survivals3==0)=[];

IScorrCoefsInfo(size(survivals3))=zeros;

    for e=1:(size(survivals3))
        
        IScorrCoefsInfo(e)=x3((survivals3(e,:)));
    end

    
%Konfrontovat  ITcorrCoefsInfo s novou situaciou ohladom stimulov co su
%relevantne
ITcorrCoefsInfo2=ITcorrCoefsInfo;
 [f,g]=setdiff(FinalSurvivals,survivals3);
 
    for index=1:(size(g))
    
    ITcorrCoefsInfo(g(index),:)=0;
end
ITcorrCoefsInfo(ITcorrCoefsInfo==0)=[];


%%Ukazat este co nepresli thr coeff

[sizeTbd,useless]=size(tbd3);
[sizeSurvivals3,useless]=size(survivals3);

% randomControl(sizeTbd)=(1:sizeTbd);
% randomControl=randperm(sizeTbd,sizeSurvivals3);

IScontrolIdent(size(randomControl))=zeros;

    for h=1:sizeTbd
        
        IScontrolIdent(h)=tbd3(h);
    end

  
    
    for j=1:sizeTbd
        
        IScontrolCorrs(j)=x3((IScontrolIdent(j)));
    end
    meanIScontrolCorrs=mean(IScontrolCorrs);
%%
%vygenerovat variable co bude rdy na plot

plotna(size(IScorrCoefsInfo)+1)=zeros;
[k,l]=size(plotna);
plotna(1:(l-1))=IScorrCoefsInfo;
plotna(l)=meanIScontrolCorrs;

% ident(size(IScorrCoefsInfo)*2)=zeros;
% [k,l]=size(ident);
% ident(1:l/2)=survivals3;
% ident(l/2+1:end)=IScontrolIdent;
% Ident=categorical(ident);
% Ident=Ident';
% 
% bar(Ident,plotna)


subplot(2,1,1)
bar(plotna)
plotna2(1,1)=mean(plotna(1:(l/2)));
plotna2(2,1)=mean(plotna(((l/2)+1):end));
subplot(2,1,2)
bar(plotna2)

end

