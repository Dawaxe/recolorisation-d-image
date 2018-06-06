function [ output ] = bilateral_filter( S,img,r,sigma_s,sigma_l )
%Applique un filtre bilateral (pondération par la différence de luminance entre 2 pixeld)
%à la cellule de descripteur passée en argument, sur un voisinage de taille 2r+1*2r+1
[hauteur, largeur] = size(S);

output = S;

%calcul de la matrice des G_sigma_s de taille 2r+1*2r+1

G_sigma_s_mat = zeros(2*r+1,2*r+1);
for i = 1:length(G_sigma_s_mat)
    for j = 1:length(G_sigma_s_mat)
        G_sigma_s_mat(i,j) = G_sigma([i j],[r+1 r+1],sigma_s);
    end
end



for i = 1:1:hauteur%on ne parcour pas l'extension de l'image
    for j = 1:1:largeur
        for k = i-r:1:i+r
            for l = j-r:1:j+r
                if((k>0) && (k<largeur) && (l>0) && (l<hauteur))
                    output{i,j} = output{i,j}+G_sigma_s_mat(k-i+r+1,l-j+r+1)*G_sigma(double(img(l,k)),double(img(j,i)),sigma_l)*(S{k,l}-S{i,j})/sqrt(2*pi*sigma_s^2);
                end
            end
        end
    end   
end

end

