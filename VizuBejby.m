function VizuBejby

for indexik=1:sizeSurvivals3

velke1=PSTH4Dall1(:,:,:,survivals3(indexik));
velke1=squeeze(velke1);
male1=velke1(1:25,:,:);
male1=mean(male1,1);
male1=squeeze(male1);


figure
imagesc(spolu1)


velke2=PSTH4Dall2(:,:,:,survivals3(indexik));
velke2=squeeze(velke2);
male2=velke2(1:25,:,:);
male2=mean(male2,1);
male2=squeeze(male2);



figure
imagesc(spolu2)
end

end

