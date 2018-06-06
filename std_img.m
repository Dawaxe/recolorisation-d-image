function [std_img_mat] = std_img(c_img,S_in,S_img,sigma_d,mu_img_mat)
%calcul l'écart type des pixels du canal passé en argument
%à partir des descripteurs des images et de l'écart type du canal
[hauteur, largeur] = size(c_img);
std_img_mat = zeros(hauteur,largeur);


for i = 1:hauteur
    i
    for j = 1:largeur
        W = 0;
        for k = 1:hauteur
            for l = 1:largeur
                distance = Distance(S_in{i,j}, S_img{k,l},sigma_d);
                std_img_mat(i,j) = std_img_mat(i,j)+(c_img(k,l)-mu_img_mat(i,j))^2*distance;               
                W = W + distance;
            end
        end
        std_img_mat(i,j) = sqrt(std_img_mat(i,j)/W);
    end
end 

end

