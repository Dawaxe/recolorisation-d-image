function [ output ] = extension( img,r )
%Etend la taille de la matrice passée en argument de r pixels de chaque côté
%chaque ligne de pixels du bord de l'image est recopié r fois
img_extended = img;
[hauteur, largeur] = size(img);

for i=1:1:r% extension en largeur_ext
    img_extended = horzcat(img(:,1),img_extended,img(:,largeur));
end

for i=1:1:r% extension en hauteur_ext
    img_extended = vertcat(img_extended(1,:),img_extended,img_extended(hauteur+i-1,:));
end

output = img_extended;


end

