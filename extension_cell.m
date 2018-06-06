function [ output ] = extension_cell( cell,r )
%Etend la taille de la cellule passée en argument de r pixels de chaque côté
%chaque ligne de pixels du bord de l'image est recopié r fois
cell_extended = cell;
[hauteur, largeur] = size(cell);


for i=1:1:r% extension en largeur_ext
    cell_extended = [cell(:,1),cell_extended,cell(:,largeur)];
end

for i=1:1:r% extension en hauteur_ext
    cell_extended = [cell_extended(1,:);cell_extended;cell_extended(hauteur+i-1,:)];
    %hauteur+i-1 car le numéro de la ligne à copier change à chaque passage
    %dans la boucle
end

output = cell_extended;

end

