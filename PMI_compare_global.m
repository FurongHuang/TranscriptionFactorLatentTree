%This is an implementation of the Block (scalar) Gaussian BP algorithm
% Written by Furong Huang, University of California, Irvine.
%
% Please report bugs to: furongh@uci.edu.

%% Compare PMI for neighbors
clear; clc;
%addpath(genpath('mi'));
load ('ARACNE_adj_theta0.1.mat');
load('LatentTreeResult_node19');
load ('yeast_id_mapping');
load ('TF_namecopy');
load  'UsefulLabel.mat';
%% find neighbors for each TF
% For ARACNE, the neighbors are found by finding the ORF name and find
% neighbors in the aracne_adj MATRIX

% For our method, the neighbors are found by selecting the union of all
% LN's neighbors


jj=1;
for i=1:size(TF_namecopy,1)
    TF_namecopy{i,3}=[];
    for j=1:size(yeast_id_mapping,1) 
        if strcmp(TF_namecopy{i,1},yeast_id_mapping{j,2})
            TF_namecopy{i,2}=yeast_id_mapping{j,1};
            for k=1:size(UsefulLabel,2)
                if strcmp(yeast_id_mapping{j,1},UsefulLabel{1,k})
                    TF_namecopy{i,3}=k;
                    break;
                end
            end
            break;
        end
    end
    if isempty(TF_namecopy{i,3})
    else
        TF_list(jj,:)=TF_namecopy(i,:);
        jj=jj+1;
    end
end
Edge=Edge+Edge';
for i=1:size(TF_list,1)
    Neighbor_ARACNE{i}=find(Edge(:,TF_list{i,3})~=0);
%     for j=1:length(Neighbor_ARACNE{i})
%         Neighbor_ARACNE_second{i}{j}=find(Edge(:,Neighbor_ARACNE{i}(j))~=0);
%     end
    
end
clear i;
clear pairDist;
clear j;
LatentNodes=1:90;
for i=1:length(LatentNodes)
        Neighbor_Ourmethod{i}=find(adjmatT(:,1035+LatentNodes(i))~=0);
%         for j=1:length(Neighbor_Ourmethod{i})
%             Neighbor_Ourmethod_second{i}{j}=find(adjmatT(:,Neighbor_Ourmethod{i}(j))~=0);
%         end
    end
%% compute multual information
load ('latentSamples.mat');
load ('LN_ConditionalMean_node19');
% LatentNodes
% latent is useful
load GeneImpu.mat;
Data=GeneImpute(:,UsefulNodes);
for i=1:length(LatentNodes)
    MI_Ourmethod{i}=[];
    for j=1:length(Neighbor_Ourmethod{i})
       MI_Ourmethod{i}=[MI_Ourmethod{i},Gaussian_MI(Data(:,Neighbor_Ourmethod{i}(j)),latent(LatentNodes(i),:)')];
    end
end
%%%

for i=1:size(TF_list,1)
    MI_ARACNE{i}=[];
    for j=1:length(Neighbor_ARACNE{i})
        MI_ARACNE{i}=[MI_ARACNE{i},Gaussian_MI(Data(:,TF_list{i,3}), Data(:,Neighbor_ARACNE{i}(j)))];
    end
end
save('global_PMIscore_node19.mat');
exit;






