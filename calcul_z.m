function [ output ] = calcul_z( img )
%Calcul le vecteur z à partir des luminances d'une image

[hauteur, largeur] = size(img);
% dérivée première

% en x
filtre_der_x = 1/6*[[1 0 -1];[1 0 -1];[1 0 -1]];
der_x = conv2(double(filtre_der_x), double(img));
der_x = der_x(1:hauteur,1:largeur);

% en y
filtre_der_y = 1/6*[[1 1 1]; [0 0 0]; [-1 -1 -1]];
der_y = conv2(double(filtre_der_y), double(img));
der_y = der_y(1:hauteur,1:largeur);

% dérivée seconde

%en x
filtre_der_2nd_x_1 = [1 -2 1];
der_2nd_x_1 = conv2(double(filtre_der_2nd_x_1),double(img));
der_2nd_x_1 = der_2nd_x_1(1:hauteur,1:largeur);

%en y
filtre_der_2nd_y_1 = [1 -2 1]';
der_2nd_y_1 = conv2(double(filtre_der_2nd_y_1),double(img));
der_2nd_y_1 = der_2nd_y_1(1:hauteur,1:largeur);

% derivée partielle en x et en y

filtre_der_x = 1/6*[[1 0 -1];[1 0 -1];[1 0 -1]];
filtre_der_y = 1/6*[[1 1 1]; [0 0 0]; [-1 -1 -1]];

der_xy = conv2(double(filtre_der_y),conv2(double(filtre_der_x),double(img)));
der_xy = der_xy(1:hauteur,1:largeur);

% création de z 

z = horzcat(double(img),der_x,der_y,der_2nd_x_1,der_2nd_y_1,der_xy);
z = reshape(z,hauteur,largeur,6);

output = z;

end

