% Script to calculate Fisher scores for group of features based on 


% Yang, Y., Chevallier, S., Wiart, J., & Bloch, I. (2014). Time-frequency 
% optimization for discrimination between imagination of right and left 
% hand movements based on two bipolar electroencephalography channels. 
% EURASIP Journal on Advances in Signal Processing, 2014(1), 38. 
% doi:10.1186/1687-6180-2014-38

% ----------------------------
% Author : Atesh Koul
% Italian Institute of technology, Genoa
% ----------------------------


% separate the positive and negative instances - in this case, large and
% small object



% have to get something like all features
% the important thing is to recursively select different features - (1,2),
% (1,3), (1,4)..all 2 combinations and then all 3 combinations


% use nchoosek for it.
% make a vector of feature means, a vector of S and then using nchoosek 
% permute over the f values.


% Select the set of features fromthe Data matrix. The features are arranged
% in wide format (e.g. Feature Wrist velocity is from 8thto 17th  column 
% (10%, 20%, 30%...100% - 10 columns), Gript Aperture feature is from 18th
% column to 27th column). The script recursively selects all features at 
% 10% columns - (8 18 40 50 60 70 80 90 100 170 180 190), then progresses
% at 20% (9 19 41 51 61 71 81 91 101 171 181 191) and so on till 
initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];

% This is done as i will start from 1. Other way to do is to use i = 0:9
% but in that case, other indicies have to be i+1. It's simpler to have
% initial_col to be initial_col-1
initial_col = initial_col -1;


% Pre allocating
featureLar = cell(1,10);
featureSma = cell(1,10);
F_all = cell(1,10);

for i = 1:10
     featureLar{i} = Data(Data(:,2)==2,initial_col+i);     
     featureSma{i} = Data(Data(:,2)==1,initial_col+i);
     meanFeatLar= mean(featureLar{1,i});
     meanFeatSma= mean(featureSma{1,i});
     
     nTrialsSma = sum(Data(:,2)==1);
     nTrialsLar = sum(Data(:,2)==2);
     
     
     SLar = (1./(nTrialsLar-1)).*sum((featureLar{1,i}-repmat(meanFeatLar,size(featureLar{1,i},1),1)).^2);
     SSma = (1./(nTrialsSma-1)).*sum((featureSma{1,1}-repmat(meanFeatSma,size(featureSma{1,i},1),1)).^2);
     %SSma = featureLar-meanFeatLar
     
     for j = 1:12
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
            end
            
        for l=1:12
            % arrange the matrix in the format for Feature 
            % Row 1 F1 : (1feature (F1 in this case)) (2 features)
            % (3 features)
            % Row 2 F2 : (1feature (F2 in this case)) (2 features)
            % (3 features)
            index = logical(sum(featMatrix==l,2));
            tmp = F(:,j);
            F_arrange{l,j}=tmp(index)';
        end
     end     
     F_all{i}=F_arrange;
end
        

% Alternate implimentation:
initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];
initial_col = initial_col -1;
for i = 1:10
     featureLar{i} = Data(Data(:,2)==2,initial_col+i);     
     featureSma{i} = Data(Data(:,2)==1,initial_col+i);
     meanFeatLar= mean(featureLar{1,i});
     meanFeatSma= mean(featureSma{1,i});
     
     SSma = featureSma{1,i};
     SLar = featureLar{1,i};
     
     %SSma = featureLar-meanFeatLar
     
     for j = 1:12
         % The combination will have to be always 12 features, what is
         % changing is the no. of the features to be taken at a time:
         % determined by the j parameter in featMatrix = nchoosek(1:12,j);
         featMatrix = nchoosek(1:12,j);
         %featMatrix = perms(1:j);
         featMatrixCheck{j} = featMatrix;
            for k=1:size(featMatrix,1)
                
                meanFeatSetLar = meanFeatLar(featMatrix(k,:));
                meanFeatSetSma = meanFeatSma(featMatrix(k,:));
                SFeatSetSSma=SSma(:,featMatrix(k,:));
                SFeatSetSLar=SLar(:,featMatrix(k,:));
                F(k,j) = (norm(meanFeatSetLar-meanFeatSetSma)).^2./(trace(cov(SFeatSetSLar))+trace(cov(SFeatSetSSma)));
                % F_arrange_feat{j,k}=F_arrange;
                    
                    
            end
            
            for l=1:12
                % arrange the matrix in the format for Feature 
                % Row 1 F1 : (1feature (F1 in this case)) (2 features)
                % (3 features)
                % Row 2 F2 : (1feature (F2 in this case)) (2 features)
                % (3 features)
                index = logical(sum(featMatrix==l,2));
                tmp = F(:,j);
                F_arrange{l,j}=tmp(index)';
            end
     end     
     F_all{i}=F_arrange;
end

% have to rearrange the F matrix




% Attempt to try to rearrange the table:
% Alternate implimentation:
% initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];
% for i = 1:1
%      featureLar{i} = Data(Data(:,2)==2,initial_col+i);     
%      featureSma{i} = Data(Data(:,2)==1,initial_col+i);
%      meanFeatLar= mean(featureLar{1,i});
%      meanFeatSma= mean(featureSma{1,i});
%      
%      SSma = featureSma{1,i};
%      SLar = featureLar{1,i};
%      
%      %SSma = featureLar-meanFeatLar
%      
%      for j = 1:2
%          % The combination will have to be always 12 features, what is
%          % changing is the no. of the features to be taken at a time:
%          % determined by the j parameter in featMatrix = nchoosek(1:12,j);
%          featMatrix = nchoosek(1:12,j);
%          %featMatrix = perms(1:j);
%          featMatrixCheck{j} = featMatrix;
%             for k=1:size(featMatrix,1)
%                 
%                 meanFeatSetLar = meanFeatLar(featMatrix(k,:));
%                 meanFeatSetSma = meanFeatSma(featMatrix(k,:));
%                 SFeatSetSSma=SSma(:,featMatrix(k,:));
%                 SFeatSetSLar=SLar(:,featMatrix(k,:));
%                 F(k,j) = (norm(meanFeatSetLar-meanFeatSetSma)).^2./(trace(cov(SFeatSetSLar))+trace(cov(SFeatSetSSma)));
%                 % F_arrange_feat{j,k}=F_arrange;
%                     
%                     
%             end
%             
%             % add another 
%             arrangeFeatMatrix = featMatrix;
%             nRowsFeatMatrix = size(arrangeFeatMatrix,1)
%             [arrangeFeatMatrix(nRowsFeatMatrix+1:2*nRowsFeatMatrix,1) arrangeFeatMatrix(nRowsFeatMatrix+1:2*nRowsFeatMatrix,2)]=deal(arrangeFeatMatrix(:,2),arrangeFeatMatrix(:,1));
%             
%             for l=1:12
%                 % arrange the matrix in the format for Feature 
%                 % Row 1 F1 : (1feature (F1 in this case)) (2 features)
%                 % (3 features)
%                 % Row 2 F2 : (1feature (F2 in this case)) (2 features)
%                 % (3 features)
%                 index = logical(sum(featMatrix==l,2));
%                 tmp = F(:,j);
%                 F_arrange{l,j}=tmp(index)';
%             end
%      end     
%      %F_all{i}={F_arrange_feat};
% end



% older implimentation in featFisher - Different in the way of arranging
% the result F-matrix.
% Alternate implimentation:
initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];
for i = 1:1
     featureLar{i} = Data(Data(:,2)==2,initial_col+i);     
     featureSma{i} = Data(Data(:,2)==1,initial_col+i);
     meanFeatLar= mean(featureLar{1,i});
     meanFeatSma= mean(featureSma{1,i});
     
     SSma = featureSma{1,i};
     SLar = featureLar{1,i};
     
     %SSma = featureLar-meanFeatLar
     
     for j = 1:1
         % The combination will have to be always 12 features, what is
         % changing is the no. of the features to be taken at a time:
         % determined by the j parameter in featMatrix = nchoosek(1:12,j);
         featMatrix = nchoosek(1:12,j);
         %featMatrix = perms(1:j);
         featMatrixCheck{j} = featMatrix;
            for k=1:size(featMatrix,1)
                
                meanFeatSetLar = meanFeatLar(featMatrix(k,:));
                meanFeatSetSma = meanFeatSma(featMatrix(k,:));
                SFeatSetSSma=SSma(:,featMatrix(k,:));
                SFeatSetSLar=SLar(:,featMatrix(k,:));
                F(k,j) = (norm(meanFeatSetLar-meanFeatSetSma)).^2./(trace(cov(SFeatSetSLar))+trace(cov(SFeatSetSSma)));
                
                for l=1:12
                    % arrange the matrix in the format for Feature 
                    % Row 1 F1 : (1feature (F1 in this case)) (2 features)
                    % (3 features)
                    % Row 2 F2 : (1feature (F2 in this case)) (2 features)
                    % (3 features)
                    index = logical(sum(featMatrix==l,2));
                    F_arrange(l,:)=F(index)';
                end
                
                    F_arrange_feat{j,k}=F_arrange;
                    
                    
            end
     end     
     F_all{i}={F_arrange_feat};
end









initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];

for i = 1:10
     featureLar{i} = Data(Data(:,2)==2,initial_col+i);     
     featureSma{i} = Data(Data(:,2)==1,initial_col+i);
     meanFeatLar{i}= mean(featureLar{1,i});
     meanFeatSma{i}= mean(featureSma{1,i});
     
     SLar = sum((featureLar{1,i}-repmat(meanFeatLar{1,i},size(featureLar{1,i},1),1)).^2);
     SSma = sum((featureSma{1,1}-repmat(meanFeatSma{1,i},size(featureSma{1,i},1),1)).^2);
     %SSma = featureLar-meanFeatLar
    
end

clear i;


for i=2:12
    featMatrix = nchoosek([1:12],i);
    for j=1:size(featMatrix,1)
        meanFeatSetLar = [meanFeatLar(featMatrix(j,:))];
        meanFeatSetSma = [meanFeatSma(featMatrix(j,:))];
        SFeatSetSSma=[SSma(featMatrix(j,:))];
        SFeatSetSLar=[SLar(featMatrix(j,:))];
        F(i,j) = sum((meanFeatLar-meanFeatSetSma).^2)./(SFeatSetSLar+SFeatSetSSma);
    end
end
        
        

        
    



% calculate the mean of features

meanLarFeat1=mean(larIns(:,8));

meanSmaFeat1=mean(smaIns(:,8));
meanLarFeat2=mean(larIns(:,18));
meanSmaFeat2=mean(smaIns(:,18));
S1sma=(1./(size(smaIns,1)-1)).*(sum((smaIns(:,8)-meanSmaFeat1).^2))
S2sma=(1./(size(smaIns,1)-1)).*(sum((smaIns(:,18)-meanSmaFeat2).^2))
S1lar=(1./(size(larIns,1)-1)).*(sum((larIns(:,8)-meanLarFeat1).^2))
S2lar=(1./(size(larIns,1)-1)).*(sum((larIns(:,18)-meanLarFeat2).^2))
F = ((meanSmaFeat1-meanLarFeat1).^2 - (meanSmaFeat2-meanLarFeat2).^2)./(S1sma+S1lar+S2lar+S2sma)




