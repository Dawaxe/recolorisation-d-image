function [ output ] = calcul_Sr( z,r )
%Calcul les descripteurs de pixels sur un voisinage de taille 2r+1*2r+1 à partir du vecteur z

[hauteur, largeur] = size(z(:,:,1));
hauteur = hauteur - 2*r;
largeur = largeur - 2*r;

%calcul de la matrice des w_r de taille 2r+1*2r+1
w_r_mat = zeros(2*r+1,2*r+1);
for i = 1:length(w_r_mat)
    for j = 1:length(w_r_mat)
        w_r_mat(i,j) = w_r([i j],[r+1 r+1],r);
    end
end

W = sum(sum(w_r_mat));%  facteur de pondération


Cr       = cell(hauteur,largeur);
Sr       = cell(hauteur,largeur);
taille_z = size(z);
taille_z = taille_z(3);
% calcul de Cr et Sr
for i = 1+r:1:hauteur+r%on ne parcour pas l'extension de l'image
    for j = 1+r:1:largeur+r
        Cr{i-r,j-r} = zeros(taille_z,taille_z);        %création de Cr{i-r,j-r}
        mu_r = [mean2(z((i-r:1:i+r),(j-r:1:j+r),1)),...%calcul de la moyenne de z sur le voisinage
                mean2(z((i-r:1:i+r),(j-r:1:j+r),2)),...
                mean2(z((i-r:1:i+r),(j-r:1:j+r),3)),...
                mean2(z((i-r:1:i+r),(j-r:1:j+r),4)),...
                mean2(z((i-r:1:i+r),(j-r:1:j+r),5)),...
                mean2(z((i-r:1:i+r),(j-r:1:j+r),6))]';
        for k = i-r:1:i+r
            for l = j-r:1:j+r              
                z_qdiffmu_r = reshape(z(k,l,:),6,1)-mu_r;%récupération du vecteur z du pixel (k,l) puis retrait de la moyenne
                Cr{i-r,j-r} = Cr{i-r,j-r} + (z_qdiffmu_r*z_qdiffmu_r')*w_r_mat(k-i+r+1,l-j+r+1);%calcul de Cr
            end
        end
        Sr{i-r,j-r}     = horzcat(chol(nearestSPD(Cr{i-r,j-r}/W))',mu_r);%calcul de Sr
        
    end   
end

output = Sr;


end

