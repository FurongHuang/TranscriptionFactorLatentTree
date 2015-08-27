%This is an implementation of the Block (scalar) Gaussian BP algorithm
% Written by Furong Huang, University of California, Irvine.
%
% Please report bugs to: furongh@uci.edu.

clear all; clc;
load('GeneImpu.mat');load('UsefulNodes.mat');load ('precision.mat');

A=precision;

numSample=size(GeneImpute,1);
Samples=GeneImpute(:,UsefulNodes);

maxround=100; epsilon=0.001;
H=inf(numSample,size(Samples,2)+90);

matlabpool 8;
parfor s=448:numSample
    tic;
    temp=Samples(s,:);
    Min=min(temp); Max=max(temp);
    %b=[temp,rand(1,90).*(Max-Min)+Min.*ones(1,90)]';
    b=[temp,zeros(1,90)]';
    [h,J,r,C] = GBP(A,b,maxround,epsilon);
    
    H(s,:)=h;
    
    toc;
end
matlabpool close;
save('LN_ConditionalMean_ZeroIni2','H');

% h is the contional marginal mean
% J is the contional marginal variance 
% Output: The solution for the inference problem
% vector h of size 1xm s.t. h = max(exp(-1/2x'Ax +x'b)). Equivalently, h = inv(A) * b;
% J - vector of the precision values Pii (the diagonal of the matrix A^-1)
% r - round number 
% C keep track of marginal mean 
% maximize the likelihood 



