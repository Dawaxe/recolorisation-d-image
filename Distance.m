function [distance] = Distance(S1,S2,sigma_d)
%Calcul la distance entre 2 descripteurs avec une pondération par sigma_d
% attention, ici S1 et S2 sont des descripteurs et non des matrices de
% descripteur

distance = exp(-(norm(S1-S2,'fro'))^2/(2*sigma_d^2));
end



