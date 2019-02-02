function VizuBejby

load('workspace.mat');

for indexik=1:sizeSurvivals3
    
figure
velke1=PSTH4Dall1(:,:,:,survivals3(indexik));
velke1=squeeze(velke1);
male1=velke1(:,1:25,:);
male1=mean(male1,2);
male1=squeeze(male1);
patternVizu1=male1';

subplot(1,2,1)
imagesc(patternVizu1)
title(survivals3(indexik))


velke2=PSTH4Dall2(:,:,:,survivals3(indexik));
velke2=squeeze(velke2);
male2=velke2(:,1:25,:);
male2=mean(male2,2);
male2=squeeze(male2);
patternVizu2=male2';


subplot(1,2,2)
imagesc(patternVizu2)
title(survivals3(indexik))
end

end

