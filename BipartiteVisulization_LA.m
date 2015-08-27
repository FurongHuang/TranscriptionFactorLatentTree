%This is an implementation of the Block (scalar) Gaussian BP algorithm
% Written by Furong Huang, University of California, Irvine.
%
% Please report bugs to: furongh@uci.edu.

% Bipartite graphs for Latent Nodes and Genes

%Step 2: generate Hidden node bipartite graph
clear;
lambda=0.3;
load(['Neighbors_node90_lambda' num2str(lambda) '.mat']);
load('LatentTreeResult_node90');
load('pairDist');
load('GeneLabel');
clear adjmatT; clear UsefulLabel;
TotalnNode=size(pairDist,2)+size(pairDist,1);
ObsernNode=size(UsefulNodes,1);
UsefulLabel=GeneLabel(UsefulNodes);
NumHidden=TotalnNode-ObsernNode;
str=cell(1,NumHidden);
for i=1:(NumHidden)
    str(1,i)={num2str(i)};
end
ticker=UsefulLabel;
newticker=[ticker,str]';
newLabel=[UsefulLabel';newticker(ObsernNode+1:TotalnNode,1)];
name=['Bipartite_LV_90nodes_lambda' num2str(lambda) '.txt'];
fileID=fopen(name,'w');
Nrows=size(H,2);
for rows=1:Nrows
    Ncols=length(H{1,rows});
    for cols=1:Ncols
        fprintf(fileID,'%d  %s  %s\n',rows,newLabel{H{1,rows}(cols)},'la');

    end
end
fclose(fileID);


% Output Hidden nodes
name1=['Bipartite_LVnodes_90nodes_lambda' num2str(lambda) '.txt'];

fileID1=fopen(name1,'w');
for i=1:90
    fprintf(fileID1,'%d\n',i);
end
fclose(fileID1);

% Output Gene nodes
name2=['Bipartite_Genenodes_90nodes_lambda' num2str(lambda) '.txt'];

fileID2=fopen(name2,'w');
i=1;
while(i<length(H)+1)
    j=1;
    while(j<length(H{1,i})+1)
    fprintf(fileID2,'%s\n',UsefulLabel{H{1,i}(j)});
    j=j+1;
    end
    i=i+1;
end
fclose(fileID2);



