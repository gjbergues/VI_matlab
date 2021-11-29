function  [PHf, PVf] = measurement13(vid)     

    n = 30;      
    PH = 1:n;
    PV = 1:n;
    x = 1:1624;
    y = 1:1234;
    
    %Captura de imagen
    frame = getsnapshot(vid);       
    Ip = double(.2989*frame(:,:,1) + .5870*frame(:,:,2) + .1140*frame(:,:,3));
   
    [ph, pv] = centercruz7(Ip);
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% LINEA HORIZONTAL DE LA CRUZ%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ IZQUIERDA ARRIBA   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if (0 < pv) && (pv < 542) && (0 < ph) && (ph < 411)
        
        xminh = pv + 30;
        yminh = ph - 15;
    
        I_ch = imcrop(Ip, [xminh yminh n-1 29]);%[xmin ymin width height]%
        %figure; imshow(I_ch, [])         
                
        for j = 1:n            
            cv = squeeze(I_ch(:, j));            
            [fith] =  fitH((1:30)', cv);%Función de fiteo de gaussiana vertical           
 
            ch = coeffvalues(fith);            
 
            PH(j) = ch(2); %Posición horizontal de la gaussiana para cada corte             
        end
        
        PHf = mean(PH) + yminh;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ IZQUIERDA CENTRO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    
    elseif (0 < pv) && (pv < 542) && (411 <= ph) && (ph < 822) 
        
        
        for j = 1:n            
            cv = squeeze(Ip(:, j+pv+30));%cortes verticales       
            [fith] =  fit(y', cv, 'gauss1');
            cH = coeffvalues(fith);       
            PH(j) = cH(2);%Posición vertical de la gaussiana para cada corte               
        end
    
        Z = PH(PH ~= min(PH));
        Z1 = Z(Z ~= min(Z));
 
        PHf = median(Z1);%posición línea horizontal              

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ IZQUIERDA ABAJO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
    elseif (0 < pv) && (pv < 542) && (822 <= ph) && (ph < 1234)    
    
        xminh = pv + 30;
        yminh = ph - 15;
    
        I_ch = imcrop(Ip, [xminh yminh n-1 29]);%[xmin ymin width height]%
        %figure; imshow(I_ch, [])         
                
        for j = 1:n            
            cv = squeeze(I_ch(:, j));            
            [fith] =  fitH((1:30)', cv);%Función de fiteo de gaussiana vertical           
 
            ch = coeffvalues(fith);            
 
            PH(j) = ch(2); %Posición horizontal de la gaussiana para cada corte             
        end
        
        PHf = mean(PH) + yminh;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ CENTRO ARRIBA   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    elseif (542 < pv) && (pv < 1082) && (0 <= ph) && (ph < 411)
        xminh = pv + 30;
        yminh = ph - 15;
    
        I_ch = imcrop(Ip, [xminh yminh n-1 29]);%[xmin ymin width height]%               
                
        for j = 1:n            
            cv = squeeze(I_ch(:, j));            
            [fith] =  fitH((1:30)', cv);%Función de fiteo de gaussiana vertical           
 
            ch = coeffvalues(fith);            
 
            PH(j) = ch(2); %Posición horizontal de la gaussiana para cada corte             
        end
        
        PHf = mean(PH) + yminh;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%    CRUZ CENTRO CENTRO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    elseif (542 < pv) && (pv < 1082) && (411 <= ph) && (ph < 822)
        
        for j = 1:n             
            cv = squeeze(Ip(:, j+pv+30));%cortes verticales       
            [fith] =  fit(y', cv, 'gauss1');
            cH = coeffvalues(fith);       
            PH(j) = cH(2);%Posición vertical de la gaussiana para cada corte               
        end
    
        Z = PH(PH ~= min(PH));
        Z1 = Z(Z ~= min(Z));
 
        PHf = median(Z1);%posición línea horizontal  
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ CENTRO ABAJO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif (542 < pv) && (pv < 1082) && (822 <= ph) && (ph < 1234) 
        xminh = pv + 30;
        yminh = ph - 15;
    
        I_ch = imcrop(Ip, [xminh yminh n-1 29]);%[xmin ymin width height]%
        %figure; imshow(I_ch, [])         
                
        for j = 1:n            
            cv = squeeze(I_ch(:, j));            
            [fith] =  fitH((1:30)', cv);%Función de fiteo de gaussiana vertical           
 
            ch = coeffvalues(fith);            
 
            PH(j) = ch(2); %Posición horizontal de la gaussiana para cada corte             
        end
        
        PHf = mean(PH) + yminh;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ DERECHA ARRIBA   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
        
    elseif (1082 <= pv) && (pv < 1624) && (0 < ph) && (ph < 411)
        
        xminh = pv - 60;
        yminh = ph - 15;
        
        I_ch = imcrop(Ip, [xminh yminh n-1 29]);%[xmin ymin width height]%
        %figure; imshow(I_ch, [])        
        
        for j = 1:n
            cv = squeeze(I_ch(:, j));            
            [fith] =  fitH((1:30)', cv);
 
            ch = coeffvalues(fith);            
 
            PH(j) = ch(2); %Posición horizontal de la gaussiana para cada corte           
        end  
        PHf = mean(PH) + yminh;        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ DERECHA CENTRO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
    
     elseif (1082 <= pv) && (pv < 1624) && (411 <= ph) && (ph < 822)        
        
        for j = 1:n             
            cv = squeeze(Ip(:, j+pv-60));%cortes verticales       
            [fith] =  fit(y', cv, 'gauss1');
            cH = coeffvalues(fith);       
            PH(j) = cH(2);%Posición vertical de la gaussiana para cada corte             
               
        end
    
        Z = PH(PH ~= min(PH));
        Z1 = Z(Z ~= min(Z));
 
        PHf = median(Z1);%posición línea horizontal              
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ DERECHA ABAJO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    elseif (1082 <= pv) && (pv < 1624) && (822 <= ph) && (ph < 1234)  
        
        xminh = pv - 60;
        yminh = ph - 15;
        
        I_ch = imcrop(Ip, [xminh yminh n-1 29]);%[xmin ymin width height]%
        %figure; imshow(I_ch, [])        
        
        for j = 1:n
            cv = squeeze(I_ch(:, j));            
            [fith] =  fitH((1:30)', cv);
 
            ch = coeffvalues(fith);            
 
            PH(j) = ch(2); %Posición horizontal de la gaussiana para cada corte           
        end  
        PHf = mean(PH) + yminh; 
    end
     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% LINEA VERTICAL DE LA CRUZ%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ IZQUIERDA ARRIBA  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    if (0 < pv) && (pv < 542) && (0 < ph) && (ph < 411)
        
        xminv = pv - 15;
        yminv = ph + 30;
        
        I_cv = imcrop(Ip, [xminv yminv 29 n-1]);%[xmin ymin width height]% 
        %figure; imshow(I_cv, [])    

        for j = 1:n
            cv2 = squeeze(I_cv(j, :))';            
            [fitv] =  fitV((1:30)', cv2);
            
            cV2 = coeffvalues(fitv);          
        
            PV(j) = cV2(2);%Posición vertical de la gaussiana para cada corte                   
        end 
        
    PVf = mean(PV) + xminv;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ IZQUIERDA CENTRO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    elseif (0 < pv) && (pv < 542) && (411 <= ph) && (ph < 822) 
        
        xminv = pv - 15;
        yminv = ph + 30;
        
        I_cv = imcrop(Ip, [xminv yminv 29 n-1]);%[xmin ymin width height]% 
        %figure; imshow(I_cv, [])    

        for j = 1:n
            cv2 = squeeze(I_cv(j, :))';            
            [fitv] =  fitV((1:30)', cv2);
            
            cV2 = coeffvalues(fitv);          
        
            PV(j) = cV2(2);%Posición vertical de la gaussiana para cada corte                   
        end 
        
    PVf = mean(PV) + xminv;      

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ IZQUIERDA ABAJO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
    elseif (0 < pv) && (pv < 542) && (822 <= ph) && (ph < 1234)    
    
        xminv = pv - 15;
        yminv = ph - 60;
        
        I_cv = imcrop(Ip, [xminv yminv 29 n-1]);%[xmin ymin width height]% 
        %figure; imshow(I_cv, [])    

        for j = 1:n
            cv2 = squeeze(I_cv(j, :))';            
            [fitv] =  fitV((1:30)', cv2);
            
            cV2 = coeffvalues(fitv);          
        
            PV(j) = cV2(2);%Posición vertical de la gaussiana para cada corte                   
        end 
        
    PVf = mean(PV) + xminv;  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ CENTRO ARRIBA   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
    elseif (542 < pv) && (pv < 1082) && (0 <= ph) && (ph < 411)        
        
        for j = 1:n
           ch = squeeze(Ip(j+ph+30, :));%cortes horizontales
       
           [fitv] =  fit(x', ch', 'gauss1');
           cV = coeffvalues(fitv);       
           PV(j) = cV(2);%Posición vertical de la gaussiana para cada corte      
              
        end     
        
        M = PV(PV ~= min(PV));
        M1 = M(M~=max(M));
        
        PVf = median(M1);  %Posición vertical  
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%    CRUZ CENTRO CENTRO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    elseif (542 < pv) && (pv < 1082) && (411 <= ph) && (ph < 822)
        
        for j = 1:n
           ch = squeeze(Ip(j+ph+30, :));%cortes horizontales
       
           [fitv] =  fit(x', ch', 'gauss1');
           cV = coeffvalues(fitv);       
           PV(j) = cV(2);%Posición vertical de la gaussiana para cada corte      
              
        end     
        
        M = PV(PV ~= min(PV));
        M1 = M(M~=max(M));
        
        PVf = median(M1);  %Posición vertical  
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ CENTRO ABAJO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif (542 < pv) && (pv < 1082) && (822 <= ph) && (ph < 1234) 
        
        for j = 1:n           
           ch = squeeze(Ip(j+ph-60, :));%cortes horizontales
       
           [fitv] =  fit(x', ch', 'gauss1');
           cV = coeffvalues(fitv);       
           PV(j) = cV(2);%Posición vertical de la gaussiana para cada corte      
              
        end     
        
        M = PV(PV ~= min(PV));
        M1 = M(M~=max(M));
        
        PVf = median(M1);  %Posición vertical  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ DERECHA ARRIBA   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
        
    elseif (1082 <= pv) && (pv < 1624) && (0 < ph) && (ph < 411)
        
        xminv = pv - 15;
        yminv = ph + 30;
        
        I_cv = imcrop(Ip, [xminv yminv 29 n-1]);%[xmin ymin width height]% 
        %figure; imshow(I_cv, [])    

        for j = 1:n
            cv2 = squeeze(I_cv(j, :))';            
            [fitv] =  fitV((1:30)', cv2);
            
            cV2 = coeffvalues(fitv);          
        
            PV(j) = cV2(2);%Posición vertical de la gaussiana para cada corte                   
        end 
        
        PVf = mean(PV) + xminv;       

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ DERECHA CENTRO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
    
     elseif (1082 <= pv) && (pv < 1624) && (411 <= ph) && (ph < 822)
        
        xminv = pv - 15;
        yminv = ph + 30;
        
        I_cv = imcrop(Ip, [xminv yminv 29 n-1]);%[xmin ymin width height]% 
        %figure; imshow(I_cv, [])    

        for j = 1:n
            cv2 = squeeze(I_cv(j, :))';            
            [fitv] =  fitV((1:30)', cv2);
            
            cV2 = coeffvalues(fitv);          
        
            PV(j) = cV2(2);%Posición vertical de la gaussiana para cada corte                   
        end 
        
    PVf = mean(PV) + xminv;           
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%    CRUZ DERECHA ABAJO   %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

    elseif (1082 <= pv) && (pv < 1624) && (822 <= ph) && (ph < 1234)  
        
        xminv = pv-15;
        yminv = ph - 60;
        
        I_cv = imcrop(Ip, [xminv yminv 29 n-1]);%[xmin ymin width height]% 
        %figure; imshow(I_cv, [])    

        for j = 1:n
            cv2 = squeeze(I_cv(j, :))';            
            [fitv] =  fitV((1:30)', cv2);
            
            cV2 = coeffvalues(fitv);          
        
            PV(j) = cV2(2);%Posición vertical de la gaussiana para cada corte                   
        end 
        
        PVf = mean(PV) + xminv; 
    end
    
          
end%FUNCTION
