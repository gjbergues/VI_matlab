%Esta función busca el centro de la escala y a la vez le quita el fondo 
%producido por el vignetting
function  [indC, indF, Isf] = scale_center(I) 
    wx = 203;
    wy = 617;
	y = 1:wy;
	x = 1:wx;
    Isf = zeros(1234,1624);
    
    
    k = 1;
    for i = 0 : 1
        ymin = i*617 + 1;
        for j = 0:7
            k = k+1;
            xmin = j*203 + 1;
            Ic = imcrop(I, [xmin ymin 202 616]);%[xmin ymin width height]%
            Ic = double(Ic);
        
            [fitresult, gof] = Fit_fondo_H(x, y, Ic);
            %figure; surf(x, y, Ig);
            [t1,t2] = meshgrid(x, y);
            promfit = fitresult(t1, t2);
            %figure; surf(t1, t2, promfit);
        
            J = abs(promfit - Ic);
            Isf((1 + i*617):(617*(i+1)),(1 + j*203):(203*(j+1))) = J;
            %figure; imagesc(J); colormap(gray)
            %figure; surf(xx, yy, J2);
        end
        xmin = 0;
    end
    
    %figure; imshow(Isf, []);
  
    i = 0;
    acbh = 0;
    
    %cuál es la columna de mayor peso?
    Sm = 0;
    for j = 100 : 1500
        cv = squeeze(Isf(:, j));%cortes verticales       
        %Se busca la columna que tiene mayor peso de intensidades.
        S = sum(cv);
        if (S > Sm)
            indC = j;
            Sm = S;
        end                  
    end
        
     %cuál es la fila de mayor peso?
     Sm = 0;
     for j = 100:1100
        ch = squeeze(Isf(j,:));%cortes horizontales
      
        S = sum(ch);
        if (S > Sm)
            indF = j;
            Sm = S;
        end                   
     end
      
end

