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
survivals1=find(x1>thrRepro)

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


thrRepro=0.05;
x2=diag(ACM);
tbd2=find(x2<thrRepro);
survivals2=find(x2>thrRepro)

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


thrRepro=0.05;
x3=diag(ACM);
tbd3=find(x3<thrRepro);
survivals3=find(x3>thrRepro)

IScorrCoefsInfo(size(survivals3))=zeros;

    for e=1:(size(survivals3))
        
        IScorrCoefsInfo(e)=x3((survivals3(e,:)));
    end
    
    
    
    
    
