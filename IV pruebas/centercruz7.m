%This function find the center without making the background substraction

function  [ph, pv] = centercruz7(Isf)
    
	bh = 1:1624;
	bv = 1:1234;

    i = 0;     
    for j = 1:1624
        i=i+1;
        cv = squeeze(Isf(:,j));%cortes verticales       
 
        [~,Inh] = max(cv);%M= valor, I=�ndices.      
        
        bh(i) = Inh; %valor central detectado para cada corte             
    end
    
        ph = round(median(bh));  %posici�n l�nea horizontal 
      
     
     
     i = 0;
     for j = 1:1234
        i=i+1;
        ch = squeeze(Isf(j,:));%cortes horizontales
      
        [~,Inv] = max(ch);%M= valor, I=�ndices.
       
        bv(i) = Inv; %valor central detectado de la gaussiana para cada corte                
     end
     
      pv = round(median(bv));  %posici�n l�nea vertical
      
end