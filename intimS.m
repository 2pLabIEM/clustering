
list=dir('Basler*');
example1=importdata(list(1,1).name);
[c,y]=size(list);
[a,b]=size(example1);



%FOR loops pre meanResposne tiffy 
%v zavislosti na fps
  
         Resp(a,b,50)=zeros;
        for n=1:50%cca200ms nastaveny ako resp bin. Kludne zmenit ale bacha aj v dalsom riadku
          
           frame=importdata(list((n),1).name);
           Resp(:,:,n)=frame;
        end
            meanResp=mean(Resp,3);
            meanRespui8=uint8(meanResp);
            filename=sprintf('meanResp%d.tif');
%             imwrite(meanRespui8,filename);

%FOR lopps na meanSpont tiffy / rovnako nastavene jak resp

   
         Spont(a,b,50)=zeros;
        for n=1:50%cca200ms nastaveny ako spont bin. Kludne zmenit ale bacha aj v dalsom riadku
           
          
               frame=importdata(list((n+50),1).name);       
    
           Spont(:,:,n)=frame;
        end
            meanSpont=mean(Spont,3);
            meanSpontui8=uint8(meanSpont);
            filename=sprintf('meanSpont%d.tif');
            
%             imwrite(meanSpontui8,filename);
     
     
% listResp=dir('meanResp*')
% [c,y]=size(listResp);
% 
% meanRespALL(a,b,c)=zeros;
% for n=1:c
%     singleMeanR=importdata(listResp(n,1).name);
%     meanRespALL(:,:,n)=singleMeanR;
% end
% meanRespALL=mean(meanRespALL,3);
% meanRespALL=uint8(meanRespALL);
% imwrite(meanRespALL,'meanRespALL.tif')
%      
% listSpont=dir('meanSpont*')
% [c,y]=size(listSpont);
% 
% meanSpontALL(a,b,c)=zeros;
% for n=1:c
%     singleMeanS=importdata(listSpont(n,1).name);
%     meanSpontALL(:,:,n)=singleMeanS;
% end
% meanSpontALL=mean(meanSpontALL,3);
% meanSpontALL=uint8(meanSpontALL);
% imwrite(meanSpontALL,'meanSpontALL.tif')
%      
% %clear all
% 
% r=imread('meanRespALL.tif');
% s=imread('meanSpontALL.tif');
