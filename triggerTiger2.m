function stimulaceT_multi


frekvence_karty=192000; %lze zmenit dle platformy

jmeno=input('Napiste jmeno base, ktera ma byt nactena. V uvozovkach.');
load(jmeno);


base=single(base);
velikost_base=size(base);
%whos
prehled=base(:,1:2);




disp('Pocet stimulu v teto baterii je')
pocet_stimulu=velikost_base(1,1)-2
disp('Delka stimulu v ms v teto baterii je')
delka_stimulu=1000*(velikost_base(1,2)-3)/frekvence_karty


pocet_cyklu=input('Zadejte, kolikrat se ma stimulacni baterie zopakovat');

kdy_trigger=input('Zadajte, jak casto triggerovat 1-pred kazdym tonem, 2-pred kazdym cyklem, 3-jinak');


perioda=input('Zadejte v ms, s jakou periodou ma probehnout stimulace.');

switch kdy_trigger
    
    case {1}
        
        disp('Zatim nic tu neni...')
        
    case {2}
             
        stim=single(zeros(1,384000+(pocet_stimulu+1)*frekvence_karty*(perioda/1000)));
        %stim(2,velikost_base(1,2))=zeros;
        [a,b]=size(stim);
        [c,d]=size(base);
        for n=1:b
        stim(1,n)=rand;
        end

       random_vectorMulti=[];
        %stimulacni_vektor=double(stimulacni_vektor);
        stimulacni_vektor=single(zeros(2,(pocet_stimulu+1)*frekvence_karty*(perioda/1000)));
        stimulacni_vektor(2,1:b)=stim(1,:);
        for projeti_cyklu=1:pocet_cyklu
            random_vector=randperm(pocet_stimulu);
            random_vectorMulti=[random_vectorMulti; random_vector];
        for sindex=1:pocet_stimulu
          
           stimulacni_vektor(1,sindex*frekvence_karty*(perioda/1000)+1:sindex*frekvence_karty*(perioda/1000)+velikost_base(1,2)-3)=base(random_vector(sindex)+1,4:end);
           [c,d]=size(stimulacni_vektor);
           stimulacni_vektor2(1,(960000))=zeros;
           stimulacni_vektor2(1,384000:848639)=stimulacni_vektor(1,:);
            
            [a,b]=size(stimulacni_vektor2);
        for n=1:b
        stim(1,n)=rand;
        end
        stimulacni_vektor2(2,1:b)=stim(1,:);
        
        
        end
                    cekani=1;
            while cekani
                cekani=input('Pro start cyklu odentruj nulu');
                if cekani==0
                    break;
                end
                
                cekani=1;
            end
        
            playerObj = audioplayer(stimulacni_vektor2, frekvence_karty, 16);
            playblocking(playerObj);
            commandwindow;
            projeti_cyklu
            

%             pause;
        stimulacni_vektor=single(zeros(2,(pocet_stimulu+1)*frekvence_karty*(perioda/1000)));
        stimulacni_vektor(2,1:b)=stim(1,:);
            
        end
        jmeno_nahodneho_vektoru=sprintf( '%02d',round(clock));
        random_vector=random_vectorMulti;
        save(jmeno_nahodneho_vektoru, 'random_vector', 'pocet_cyklu', 'kdy_trigger','perioda');
        save('abc.mat');
        %t=timer;
        %set(t, 'ErrorFcn', 'disp(''Nestiham nebo je nekde chyba'')');
        %set(t, 'BusyMode', 'error');
        %set(t, 'ExecutionMode', 'fixedRate');
        
        
        %set(t, 'Period', perioda_cyklu);
        %set(t, 'StartDelay', 5);
        %set(t, 'TasksToExecute', pocet_cyklu);
        %get(t)
        
        %set(t, 'TimerFcn', sound(stimulacni_vektor, frekvence_karty)');
        %set(t, 'StartFcn', 'tic');
        %set(t, 'StopFcn', 'toc');
        %start (t);
        
disp('Stimulace probìhla úspìšnì.')
        
    case {3}
        
        stimulacni_vektor=single(zeros(2,(pocet_stimulu+1)*frekvence_karty*(perioda/1000)));
        stimulacni_vektor(2,1:velikost_base(1,2)-3)=base(1,4:end);
        
         playerObj = audioplayer(stimulacni_vektor, frekvence_karty, 16);
            playblocking(playerObj);
            commandwindow;
            projeti_cyklu
        
    otherwise
        
        disp('No tak nic no...')
        
        
        
        
end
end












