initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];

% This is done as i will start from 1. Other way to do is to use i = 0:9
% but in that case, other indicies have to be i+1. It's simpler to have
% initial_col to be initial_col-1
initial_col = initial_col -1;


% Pre allocating
featureLar = cell(1,10);
featureSma = cell(1,10);
F_all = cell(1,10);

for i = 1:2
     featureLar{i} = Data(Data(:,2)==2,initial_col+i);     
     featureSma{i} = Data(Data(:,2)==1,initial_col+i);
     meanFeatLar= mean(featureLar{1,i});
     meanFeatSma= mean(featureSma{1,i});
     
     nTrialsSma = sum(Data(:,2)==1);
     nTrialsLar = sum(Data(:,2)==2);
     
     
     SLar = (1./(nTrialsLar-1)).*sum((featureLar{1,i}-repmat(meanFeatLar,size(featureLar{1,i},1),1)).^2);
     SSma = (1./(nTrialsSma-1)).*sum((featureSma{1,i}-repmat(meanFeatSma,size(featureSma{1,i},1),1)).^2);
     %SSma = featureLar-meanFeatLar
     
     for j = 1:2
         % The combination will have to be always 12 features, what is
         % changing is the no. of the features to be taken at a time:
         % determined by the j parameter in featMatrix = nchoosek(1:12,j);
         featMatrix = nchoosek(1:12,j);
         %featMatrix = perms(1:j);
         featMatrixCheck{i} = featMatrix;
            for k=1:size(featMatrix,1)
                meanFeatSetLar = meanFeatLar(featMatrix(k,:));
                meanFeatSetSma = meanFeatSma(featMatrix(k,:));
                SFeatSetSSma=SSma(featMatrix(k,:));
                SFeatSetSLar=SLar(featMatrix(k,:));
                F(k,j) = sum((meanFeatSetLar-meanFeatSetSma).^2)./sum((SFeatSetSLar+SFeatSetSSma));
                %sum((meanFeatSetLar-meanFeatSetSma).^2)./sum((SFeatSetSLar+SFeatSetSSma))
                
            end
            

     end
end