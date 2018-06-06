function [ output ] = w_r( p,q,r )
%w_r retourne le facteur de normalisation de la 
%matrice de covariance de z calculé avec les pixel p et q
%sur un voisinage de taille (2r+1) * (2r+1)
%p et q doivent être des matrices (1,2)
%   retourne un double
output = exp(-9*((p-q)*(p-q)')/(2*r^2));

end

