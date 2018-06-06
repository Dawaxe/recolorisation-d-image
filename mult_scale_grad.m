function [output] = mult_scale_grad(Srmax,z,rmax)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[hauteur, largeur] = size(Srmax);
output = Srmax;

%initialisation des matrices de coordonnées Mx et My

[My_coor, Mx_coor] = meshgrid(1:hauteur,1:largeur);
Mx = Mx_coor;
My = My_coor;


for r = 1:rmax
    Sr        = calcul_Sr(z,r);
    Sr_extended = extension_cell(Sr,r);
    Vr          = calcul_Vr(Sr_extended,r);
    [Mx, My]    = grad_descent(Mx, My,Vr);    
end

for i = 1:hauteur
    for j = 1:largeur
    output(i,j) = Srmax(Mx(i,j),My(i,j));        
    end
end
end

