function [Ploss, Qloss] = calcLosses(Sij, Sji)
% calcLosses - Calculates total real and reactive transmission line losses

Ploss = sum(real(Sij + Sji));
Qloss = sum(imag(Sij + Sji));

end