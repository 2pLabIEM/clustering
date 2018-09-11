%na analyzu intrinsic imaging

clear all

prompt='pocet stimulov';
i=input(prompt);
prompt='interstimulus';
j=input(prompt);
prompt='fps';
k=input(prompt);

j2=j*k; %aby sme sekundy previedli na frames
step_vektor=round(1:j2:(i*j2));

%timebin=round(k/4);   %pre gcamp 
timebin=round(k*2);         %pre intrinsic urcite 2s average - takze min 5s interstim

list=dir('Basler*');
example1=importdata(list(1,1).name);
[c,y]=size(list);
[a,b]=size(example1);



%FOR loops pre meanResposne tiffy 
%v zavislosti na fps
    for m=step_vektor
         Resp(a,b,timebin)=zeros;
        for n=1:timebin%cca200ms nastaveny ako resp bin. Kludne zmenit ale bacha aj v dalsom riadku
          
           frame=importdata(list((m+n-1),1).name);
           Resp(:,:,n)=frame;
        end
            meanResp=mean(Resp,3);
            meanRespui8=uint8(meanResp);
            filename=sprintf('meanResp%d.tif',m-1);
            imwrite(meanRespui8,filename);
    end
%FOR lopps na meanSpont tiffy / rovnako nastavene jak resp

     for m=step_vektor
         Spont(a,b,timebin)=zeros;
        for n=1:timebin%cca200ms nastaveny ako spont bin. Kludne zmenit ale bacha aj v dalsom riadku
           
           if m==1
               frame=importdata(list((m+round(j2)-n-1),1).name);
           else
               frame=importdata(list((m+round(j2)-n),1).name);
           end
    
           Spont(:,:,n)=frame;
        end
            meanSpont=mean(Spont,3);
            meanSpontui8=uint8(meanSpont);
            filename=sprintf('meanSpont%d.tif',m-1);
            
            imwrite(meanSpontui8,filename);
     end
     
listResp=dir('meanResp*')
[c,y]=size(listResp);

meanRespALL(a,b,c)=zeros;
for n=1:c
    singleMeanR=importdata(listResp(n,1).name);
    meanRespALL(:,:,n)=singleMeanR;
end
meanRespALL=mean(meanRespALL,3);
meanRespALL=uint8(meanRespALL);
imwrite(meanRespALL,'meanRespALL.tif')
     
listSpont=dir('meanSpont*')
[c,y]=size(listSpont);

meanSpontALL(a,b,c)=zeros;
for n=1:c
    singleMeanS=importdata(listSpont(n,1).name);
    meanSpontALL(:,:,n)=singleMeanS;
end
meanSpontALL=mean(meanSpontALL,3);
meanSpontALL=uint8(meanSpontALL);
imwrite(meanSpontALL,'meanSpontALL.tif')
     
%clear all

r=imread('meanRespALL.tif');
s=imread('meanSpontALL.tif');

a=imsubtract(r,s);
a2=imdivide(a,s);


   