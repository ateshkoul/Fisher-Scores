% Script to test if the data is distribution is normal for the features

% ----------------------------
% Author : Atesh Koul
% Italian Institute of technology, Genoa
% ----------------------------

% Select the features that we are intested in:
features = Data(:,[8:27 40:109 170:199]);

% Repeat for the two objects - small and large
for i = 1:2
    % repeat for all the features
    for j=1:size(features,2)
        % Calcuate the probability and p-value of the test: You can choose
        % watever test that u like but just keep in mind the idea that
        % different tests might be testing different null hypothesis
        %[gaus(j,i) p(j,i)]=kstest(log(features(Data(:,2)==i,j)));
        gaus(j,i)=lillietest(features(Data(:,2)==i,j));
        % gaus(j,i)==1 in case of kstest
            if (gaus(j,i)==0)
                i
                j
                sprintf('not gausian')
            end
    end
end


% Test for multi-variate test for gaussian distribution
clear i;
initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];
for i=0:9
    HZmvntest(Data(:,initial_col+i))
end


% Create and print (save to file) the histograms of all the data
features = Data(:,[8:27 40:109 170:199]);
clear i j;
for j = 1:2
for i=1:size(features,2)
    hist(features(Data(:,2)==j,i))
    print('-djpeg',strcat(num2str(i),'-',num2str(j)))
end
end

% another way of testing the normality of the data using the skewness
% measure. Although not implemented here.
features = Data(:,[8:27 40:109 170:199]);
for i = 1:size(features,2)
    gaus(i)=skewness(features(:,i)');
    if (gaus(i)==0)
        i
        sprintf('not gausian')
    end
end


% Z-transform

for i = 1:size(pep,2)
hist(pep(:,i))
print('-djpeg',num2str(i))

end



% Two standard deviations
for j=1:2
    features = Data(Data(:,2)==j,[8:27 40:109 170:199]);
    
for i=1:size(features,2)
    X_norm{j}(:,i) = (features(:,i)-mean(features(:,i)))./std(features(:,i));
    %X_norm{j} = X{j};
    if any(X_norm{j}(:,i)>(2.*std(X_norm{j}(:,i))) | X_norm{j}(:,i)<(-2.*std(X_norm{j}(:,i))))
        a = find(X_norm{j}(:,i)>(2.*std(X_norm{j}(:,i))) | X_norm{j}(:,i)<(-2.*std(X_norm{j}(:,i))));
        X_norm{j}(a,i)=NaN;
    end
    
   
end
end



% Two standard deviations from origional values
for j=1:2
    features = Data(Data(:,2)==j,[8:27 40:109 170:199]);
    
for i=1:size(features,2)
    X_norm{j}(:,i) = features(:,i);
    %X_norm{j} = X{j};
    if any(X_norm{j}(:,i)>(mean(X_norm{j}(:,i))+2.*std(X_norm{j}(:,i))) | X_norm{j}(:,i)<(mean(X_norm{j}(:,i))-2.*std(X_norm{j}(:,i))))
        a = find(X_norm{j}(:,i)>(mean(X_norm{j}(:,i))+2.*std(X_norm{j}(:,i))) | X_norm{j}(:,i)<(mean(X_norm{j}(:,i))-2.*std(X_norm{j}(:,i))));
        X_norm{j}(a,i)=NaN;
    end
    
   
end
end



clear a i j;
for i =1:2
for j=1:120
a(i,j)=sum(isnan(X_norm{i}(:,j)));
end
end


for i=1:2
    for j=1:120
    a(i,j)=sum(isnan(X_norm{i}(:,j)));
    end
end

pep=+isnan(X_norm{1})
pep(pep==1)=NaN;
pep(pep==0)=1;
features= features.*pep











% From interpolated to another interpolation

for i =1:15
peppa{i} = cat(1,b{i,:})
end
sortrows(peppa{1,1})
for i = 1:15
peppa{i}=sortrows(peppa{i})
end
help xlswrite
for i =1:15
xlswrite('Data_interpolated_Z_out.xls',peppa{i},strcat('Sheet',num2str(i)))
end



for j=1:2
    features = Data(Data(:,2)==j,[8:27 40:109 170:199]);
    
for i=1:size(features,2)
    X_norm{j}(:,i) = features(:,i);
    %X_norm{j} = X{j};
    if any(X_norm{j}(:,i)>(mean(X_norm{j}(:,i))+2.*std(X_norm{j}(:,i))) | X_norm{j}(:,i)<(mean(X_norm{j}(:,i))-2.*std(X_norm{j}(:,i))))
        a = find(X_norm{j}(:,i)>(mean(X_norm{j}(:,i))+2.*std(X_norm{j}(:,i))) | X_norm{j}(:,i)<(mean(X_norm{j}(:,i))-2.*std(X_norm{j}(:,i))));
        X_norm{j}(a,i)=NaN;
    end
    
   
end
end



for i = 1:2
    for j=1:120
        if any(isnan(X_norm{i}(:,j)))
            X_norm{i}(isnan(X_norm{i}(:,j)),j) = nanmean(X_norm{i}(:,j),1);            
        end
    end 
end







