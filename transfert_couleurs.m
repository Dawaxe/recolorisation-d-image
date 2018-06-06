function [output] = transfert_couleurs(std_ref,std_in,mu_ref,mu_in,c_in)
%Applique le transfert de couleur au canal passé en argument
%avec les paramètres de gaussienne passés en argument
[hauteur, largeur] = size(c_in);
output = zeros(hauteur,largeur);


for i = 1:hauteur
    for j = 1:largeur
        output(i,j) = std_ref(i,j)/std_in(i,j)*(c_in(i,j)-mu_in(i,j))+mu_ref(i,j);
    end
end

end

