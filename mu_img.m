function [mu_img_mat] = mu_img(c_img,S_in,S_img,sigma_d)
%calcul la moyenne pondérée par la distance entre descripteurs du canal
%passé en argument
[hauteur, largeur] = size(c_img);
mu_img_mat = zeros(hauteur,largeur);




for i = 1:hauteur
    i
    for j = 1:largeur
        W = 0;
        for k = 1:hauteur
           for l = 1:largeur
                distance = Distance(S_in{i,j}, S_img{k,l},sigma_d);
%                 if distance ~= 0
%                     [i,k,j,l,distance,W, c_img(k,l)*distance]
%                 end
                mu_img_mat(i,j) = mu_img_mat(i,j) + c_img(k,l)*distance;
                W = W + sum(sum(distance));
            end
        end
        mu_img_mat(i,j) = mu_img_mat(i,j)/W;
    end
end 
end



