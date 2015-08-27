%This is an implementation of the Block (scalar) Gaussian BP algorithm
% Written by Furong Huang, University of California, Irvine.
%
% Please report bugs to: furongh@uci.edu.

clear all; clc;
load('GeneImpu.mat');load('UsefulNodes.mat');load ('precision.mat');
nHidden=19;
A=precision;

numSample=size(GeneImpute,1);
Samples=GeneImpute(:,UsefulNodes);

maxround=100; epsilon=0.001;
H=inf(numSample,size(Samples,2)+nHidden);
if (matlabpool('size') > 0)
else
    matlabpool 4;
end
parfor s=129:numSample
    b=[Samples(s,:),zeros(1,nHidden)]';
    %clear h; 
    [h,J,r,C] = GBP(A,b,maxround,epsilon);
    H(s,:)=h;
end

save('LN_ConditionalMean_node19','H');

% h is the contional marginal mean
% J is the contional marginal variance 
% Output: The solution for the inference problem
% vector h of size 1xm s.t. h = max(exp(-1/2x'Ax +x'b)). Equivalently, h = inv(A) * b;
% J - vector of the precision values Pii (the diagonal of the matrix A^-1)
% r - round number 
% C keep track of marginal mean 
% maximize the likelihood 



