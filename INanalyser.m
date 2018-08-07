clear all

 list=dir('neuron*.mat');
 [x,q]=size(list(:,1));
 
 for g=2:x
 load(list(g,1).name);

%load('neuron005.mat');
[a,b,c,d]=size(Tracesindividual);
q=squeeze(Tracesindividual);
r=q(:,1:25,:); %bereme bin prvych 250ms

megaMatrix(11,11,x)=zeros;

for n=1:d
    for m=1:a
        for l=1:d
            for k=1:a
                [p,h]=ranksum(r(m,:,n),r(k,:,l));
  
                ACM(m+((n*a)-a),k+((l*a)-a))=p;
          
            end
        end
    end
end

mACM(11,11)=zeros;

for j=1:11
    for i=1:11
        pixel=ACM((a*j-9):a*j,(a*i-9):a*i);
         mean1=mean(pixel);
         meanP=mean(mean1);
         mACM(j,i)=meanP;
        
    end
end
imagesc(mACM)
 megaMatrix(:,:,g)=mACM;

 end

finalRep=mean(megaMatrix,3);
finalRep=squeeze(finalRep);
imagesc(finalRep)
