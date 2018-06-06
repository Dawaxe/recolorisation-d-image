function [ output ] = calcul_nu_r( cell_in )
%Calcul le descripteur moyen de la matrice descripteurs passée en argument
[i,j] = size(cell_in);
nbr_case = i*j;
[a,b] = size(cell_in{1,1});
A = zeros(a,b);
for k = 1:1:a
    for l = 1:1:b
        if (k>=l) || (l == b)%évite de faire des calculs sur les cases des descripteurs qui vallent toujours 0
        for m = 1:1:i
            for n = 1:1:j
                A(k,l) = A(k,l) + cell_in{m,n}(k,l);
            end
        end
        end
        A(k,l) = A(k,l)/nbr_case;
    end
end

output = A;
end

