function [ output ] = calcul_Sr_aff( Sr )
%Calcul la norme de frobinus des descripteurs de la cellule passée en argument
%dans le but de les afficher ensuite
[hauteur, largeur] = size(Sr);
Sr_aff = zeros(hauteur,largeur);
for i = 1:hauteur
    for j = 1:largeur
        Sr_aff(i,j) = norm(Sr{i,j},'fro');
    end
end 
output = Sr_aff;
end

