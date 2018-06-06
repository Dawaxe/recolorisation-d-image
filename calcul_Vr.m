function [ output ] = calcul_Vr( Sr_extended,r )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[hauteur, largeur] = size(Sr_extended);
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

Vr_temp =  cell(hauteur,largeur);
Vr = zeros(hauteur,largeur);

for i = 1+r:1:hauteur+r%on ne parcour pas l'extension de l'image
    for j = 1+r:1:largeur+r
        nu_r = calcul_nu_r(Sr_extended(i-r:i+r,j-r:j+r));
        Vr_temp{i-r,j-r} = zeros(6,6);
        for k = i-r:1:i+r
            for l = j-r:1:j+r
                diff = Sr_extended{k,l}-nu_r;%permet de ne pas calculer 2 fois la différence Sr-nu_r
                Vr_temp{i-r,j-r} = Vr_temp{i-r,j-r} + diff*diff'*w_r_mat(k-i+r+1,l-j+r+1);
            end
        end
        Vr(i-r,j-r) = norm(Vr_temp{i-r,j-r}/W,'fro');
    end   
end
output = Vr;


end

