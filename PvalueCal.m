%This is an implementation of the Block (scalar) Gaussian BP algorithm
% Written by Furong Huang, University of California, Irvine.
%
% Please report bugs to: furongh@uci.edu.

clear;
load('TF.mat');
lambda=0.15;
load(['Neighbors_node90_lambda' num2str(lambda) '.mat']);%%%
%leftPvalue=zeros(length(T),length(H));
rightPvalue=zeros(length(T),length(H));
%twoPvalue=zeros(length(T),length(H));

for i=1:length(T)
    for j=1:length(H)
        cont=zeros(2,2);
        for index=1:1035
            if (any(T{1,i}==index) && any(H{1,j}==index)) 
                cont(1,1)=cont(1,1)+1;
            else
                if (any(T{1,i}==index) && ~(any(H{1,j}==index)))
                    cont(1,2)=cont(1,2)+1;
                else
                    if (~(any(T{1,i}==index)) && any(H{1,j}==index)) 
                        cont(2,1)=cont(2,1)+1;
                    else
                        if (~(any(T{1,i}==index)) && ~(any(H{1,j}==index))) 
                            cont(2,2)=cont(2,2)+1;
                        end
                    end
                end
            end
            
        end
        p=myfisher(cont);
        %leftPvalue(i,j)=p(1);
        rightPvalue(i,j)=p(2);
        %twoPvalue(i,j)=p(3);
    end
end



fileID=fopen(['lambda' num2str(lambda) 'rightPValueResults_node90.txt'],'w');%%%
for i=1:size(rightPvalue,1)
    fprintf(fileID, '%s',TF_namecopy{i,1});
    for j=1:length(H)
    fprintf(fileID, '\t%f',rightPvalue(i,j));
    end
    fprintf(fileID, '\n');
end
fclose(fileID);
save(['lambda' num2str(lambda) 'pValueResults_node90.mat']);%%%



% fileID=fopen(['r' num2str(r) 'leftPValueResults.txt'],'w');
% for i=1:size(twoPvalue,1)
% fprintf(fileID, '%s \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f\n',TF_namecopy{i,1},leftPvalue(i,:));
% end
% fclose(fileID);

% fileID=fopen(['r' num2str(r) 'rightPValueResults.txt'],'w');
% for i=1:size(twoPvalue,1)
% fprintf(fileID, '%s \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f\n',TF_namecopy{i,1},rightPvalue(i,:));
% end
% fclose(fileID);

% fileID=fopen(['r' num2str(r) 'twoPValueResults.txt'],'w');
% for i=1:size(twoPvalue,1)
% fprintf(fileID, '%s \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f \t %f\n',TF_namecopy{i,1},twoPvalue(i,:));
% end
% fclose(fileID);
