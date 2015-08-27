%This is an implementation of the Block (scalar) Gaussian BP algorithm
% Written by Furong Huang, University of California, Irvine.
%
% Please report bugs to: furongh@uci.edu.

% Bipartite graph visualization

% Step 1: generate TF bipartite graph
clear; clc;
load('TF.mat');
fileID=fopen('Bipartite_TF.txt','w');

i=1;
while(i<length(T)+1)
    j=1;
    while(j<length(T{1,i})+1)
    fprintf(fileID,'%s %s %s\n',TF_namecopy{i,1},UsefulLabel{T{1,i}(j)},'pd');
    j=j+1;
    end
 
    i=i+1;
end
fclose(fileID);

% Output TF nodes
fileID2=fopen('Bipartite_TFnodes.txt','w');
i=1;
while(i<length(T)+1)
    fprintf(fileID2,'%s\n',TF_namecopy{i,1});
    i=i+1;
end

fclose(fileID2);
% Output Gene nodes
fileID3=fopen('Bipartite_Genenodes.txt','w');
i=1;
while(i<length(T)+1)
    j=1;
    while(j<length(T{1,i})+1)
    fprintf(fileID3,'%s\n',UsefulLabel{T{1,i}(j)});
    j=j+1;
    end
    i=i+1;
end
fclose(fileID3);


