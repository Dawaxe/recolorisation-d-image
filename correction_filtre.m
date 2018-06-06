function [ Srmax ] = correction_filtre( Srmax,Srmax_init )
%Supprime les valeurs aberrantes obtenues après filtrage bilatéral
%ces valeurs sont remplacée par la valeur avant filtrage 
norm_init = calcul_Sr_aff(Srmax_init);
norm      = calcul_Sr_aff(Srmax);
[hauteur, largeur] = size(Srmax);
maxi = max(norm_init);

for i = 1:1:hauteur
    for j = 1:1:largeur
        if (norm(i,j)>maxi + 50)
            Srmax(i,j) = Srmax_init(i,j);
        end
    end
end
end

