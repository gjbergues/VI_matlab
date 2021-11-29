function [Dxy] = scale_calibrationE(vid)    
    
    BVV = 1:50;
    BHH = 1:15;     
    
    frame = getsnapshot(vid);    
    I = double(.2989*frame(:,:,1) + .5870*frame(:,:,2) + .1140*frame(:,:,3));
      
    %Obtengo el centro de la retícula.
    %Isf=image without backgroud
    [indC, indF, Isf] = scale_center(I); 

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%% ANÁLISIS HORIZONTAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    x = 1:770;
    xmin = indC - 440;
    ymin = indF - 70;
    %corte de la imagen
    Ic = imcrop(Isf, [xmin ymin 769 49]);%[xmin ymin width height]%

    for j = 1 : 15  
        ch = squeeze(Ic(j,:));%cortes horizontales
        %fitting de 8 gaussianas
        [fith, gofh] = Fit_8gauss_H(x, ch);
        %obtengo los coeficientes de las gaussianas
        cH = coeffvalues(fith);
        bH = reshape(cH, 3, 8);
        b_fH = sort(bH(2,:));
        X = [ones(1,8)' (1:8)'];
        BH = b_fH';
        %modelo de regresión con los 8 centros de las gaussianas
        [bh] = regress(BH, X);
        BHH(j) = bh(2);
    end
    %Paso horizontal de la escala (en eje X).
    DX = mean(BHH);    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%% ANÁLISIS VERTICAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    yv = 1:770;   
    xmin = indC - 60;
    ymin = indF - 330;
    %corte de la imagen
    Icv = imcrop(Isf, [xmin ymin 49 769]);%[xmin ymin width height]%

    for j= 1 : 50
        cv = squeeze(Icv(:,j))';
        [fitv] = Fit_8gauss_V(yv, cv);
        cV = coeffvalues(fitv);
        bV = reshape(cV, 3, 8);
        b_fV = sort(bV(2, :));
        X = [ones(1,8)' (1:8)'];
        BV = b_fV';
        [bv] = regress(BV, X);        
        BVV(j) = bv(2);
    end
    %Pasa vertical de la escala (en eje Y)
    DY = mean(BVV);   

    %Cálculo de DELTA XY, la distancia entre segmentos consecutivos de la
    %escala:

    Dxy = (DX + DY)/2;