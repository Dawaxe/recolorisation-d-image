function [ Mx,My ] = grad_descent( Mx, My,Vr )
%Applique une descente de gradient à la matrice passé en argument
%les coordonnées comptenues dans Mx et My sont mise à jour
[hauteur, largeur] = size(Mx);
%dérivées de Vr
filtre_der_x = 1/6*[[1 0 -1];[1 0 -1];[1 0 -1]];
der_x_Vr = conv2(double(Vr), double(filtre_der_x), 'same');

filtre_der_y = 1/6*[[1 1 1]; [0 0 0]; [-1 -1 -1]];
der_y_Vr = conv2(double(Vr), double(filtre_der_y),'same');

for i = 1:hauteur
    for j = 1:largeur
        for k = 1:10
            Mx_temp = Mx(i,j);
            Mx(i,j) = uint16(Mx(i,j) - 0.015*der_x_Vr(Mx(i,j),My(i,j)));
            if Mx(i,j) <= 0
                Mx(i,j) = 1;
            end
            if Mx(i,j) > largeur 
                Mx(i,j) = largeur;
            end
            My(i,j) = uint16(My(i,j) - 0.015*der_y_Vr(Mx_temp,My(i,j)));
            if My(i,j) <= 0
                My(i,j) = 1;
            end
            if My(i,j) > hauteur 
                My(i,j) = hauteur;
            end
        end
    end
end



end

