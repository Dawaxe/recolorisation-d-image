%close all
clear
clc
tic

% ouverture de l'image et conversion en noir et blanc
img_color_in       = imread('bw.png');
img_in             = rgb2gray(img_color_in);
img_color_ref      = imread('vegetation.png');
img_ref            = rgb2gray(img_color_ref);
[hauteur, largeur] = size(img_in);

%choix de la taille du voisinage
rmax               = 6;

%calcul des descripteurs
img_extended_in = extension(img_in,rmax);
z_in            = calcul_z(img_extended_in);
Srmax_in        = calcul_Sr(z_in,rmax);
Srmax_init_in   = Srmax_in;
figure;
imagesc(calcul_Sr_aff(Srmax_in));title('Srmax_in');

img_extended_ref = extension(img_ref,rmax);
z_ref            = calcul_z(img_extended_ref);
Srmax_ref        = calcul_Sr(z_ref,rmax);
Srmax_init_ref   = Srmax_ref;

figure;
imagesc(calcul_Sr_aff(Srmax_ref));title('Srmax_ref');


%descente de gradiant multi-échelle

Srmax_in  = mult_scale_grad(Srmax_in,z_in,rmax);
Srmax_ref = mult_scale_grad(Srmax_ref,z_ref,rmax);

% figure;imagesc(img);title('image');colormap(gray);
figure;imagesc(calcul_Sr_aff(Srmax_in));title('Srmax_in_d');
figure;imagesc(calcul_Sr_aff(Srmax_ref));title('Srmax_ref_d');


%filtrage bilatéral

sigma_s = 1;
sigma_l = 0.05;
sigma_d = 15;

for n = 1:1:200
    Srmax_in = bilateral_filter(Srmax_in,img_in,rmax,sigma_s,sigma_l);     
    n
end

figure;imagesc(calcul_Sr_aff(Srmax_in));title('Srmax_i_n filtered sigma_s = 0.25');

for n = 1:1:200
    Srmax_ref = bilateral_filter(Srmax_ref,img_ref,rmax,sigma_s,sigma_l);     
    n
end

figure;imagesc(calcul_Sr_aff(Srmax_ref));title('Srmax_r_e_f filtered');

Srmax_ref = correction_filtre(Srmax_ref,Srmax_init_ref);
Srmax_in = correction_filtre(Srmax_in,Srmax_init_in);

%passage dans le domaine L,a,b
img_lab_in = rgb2lab(img_color_in);
L_in = img_lab_in(:,:,1);
a_in = img_lab_in(:,:,2);
b_in = img_lab_in(:,:,3);

img_lab_ref = rgb2lab(img_color_ref);
L_ref = img_lab_ref(:,:,1);
a_ref = img_lab_ref(:,:,2);
b_ref = img_lab_ref(:,:,3);

% calcul des moyennes pondérées

%canal L
mu_L_in  = mu_img(L_in,Srmax_in,Srmax_in,sigma_d);
mu_L_ref = mu_img(L_ref,Srmax_in,Srmax_ref,sigma_d);

% canal a
mu_a_in  = mu_img(a_in,Srmax_in,Srmax_in,sigma_d);
mu_a_ref = mu_img(a_ref,Srmax_in,Srmax_ref,sigma_d);

%canal b
mu_b_in  = mu_img(b_in,Srmax_in,Srmax_in,sigma_d);
mu_b_ref = mu_img(b_ref,Srmax_in,Srmax_ref,sigma_d);

% calcul des écarts type 

%canal L
std_L_in  = std_img(L_in,Srmax_in,Srmax_in,sigma_d,mu_L_in);
std_L_ref = std_img(L_ref,Srmax_in,Srmax_ref,sigma_d,mu_L_ref);

% canal a
std_a_in  = std_img(a_in,Srmax_in,Srmax_in,sigma_d,mu_a_in);
std_a_ref = std_img(a_ref,Srmax_in,Srmax_ref,sigma_d,mu_a_ref);

%canal b
std_b_in  = std_img(b_in,Srmax_in,Srmax_in,sigma_d,mu_b_in);
std_b_ref = std_img(b_ref,Srmax_in,Srmax_ref,sigma_d,mu_b_ref);

%Transfert des couleurs

%canal L
L_trans = transfert_couleurs(std_L_ref,std_L_in,mu_L_ref,mu_L_in,L_in);

%canal a
a_trans = transfert_couleurs(std_a_ref,std_a_in,mu_a_ref,mu_a_in,a_in);

%canal b
b_trans = transfert_couleurs(std_b_ref,std_b_in,mu_b_ref,mu_b_in,b_in);

%construction de l'image recolorisée en Lab
img_recolor_Lab = cat(3,L_trans,a_trans,b_trans);

%construction de l'image recolorisée en RGB
img_recolor_RGB = lab2rgb(img_recolor_Lab);

figure,image(img_recolor_RGB);axis image;title('sigma_d = 15')


 