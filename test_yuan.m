
% Function to calculate Fisher scores for group of features based on the
% paper:

% Yang, Y., Chevallier, S., Wiart, J., & Bloch, I. (2014). Time-frequency 
% optimization for discrimination between imagination of right and left 
% hand movements based on two bipolar electroencephalography channels. 
% EURASIP Journal on Advances in Signal Processing, 2014(1), 38. 
% doi:10.1186/1687-6180-2014-38


% Input : Data from kinematics analysis in the form of a variable.
% The Data has to conform to the form with the following header set. The
% data also has to be complete from all subjects.

% header = [{'Trial','Condizione','Durata Movimento [s]','Massima velocita polso [mm/s]'
% 'V_max % [0 1]','Massima apertura ','T_Ap_max %','WristVel_01','WristVel_02','WristVel_03',
% 'WristVel_04','WristVel_05','WristVel_06','WristVel_07','WristVel_08','WristVel_09','WristVel_10',
% 'Apertura_01','Apertura_02','Apertura_03','Apertura_04','Apertura_05','Apertura_06','Apertura_07',
% 'Apertura_08','Apertura_09','Apertura_10','Centroide X','Centroide Y','Centroide Z','Centroide X_std',
% 'Centroide Y_std','Centroide Z_std','LughezzaTraiettoria','Delay','DeltaSec','DeltaFrame',
% 'MaxAcceleration','MaxDeceleration','Z_Wrist_01','Z_Wrist_02','Z_Wrist_03','Z_Wrist_04',
% 'Z_Wrist_05','Z_Wrist_06','Z_Wrist_07','Z_Wrist_08','Z_Wrist_09','Z_Wrist_10','X_IndexRuotato_01',
% 'X_IndexRuotato_02','X_IndexRuotato_03','X_IndexRuotato_04','X_IndexRuotato_05','X_IndexRuotato_06',
% 'X_IndexRuotato_07','X_IndexRuotato_08','X_IndexRuotato_09','X_IndexRuotato_10','Y_IndexRuotato_01',
% 'Y_IndexRuotato_02','Y_IndexRuotato_03','Y_IndexRuotato_04','Y_IndexRuotato_05','Y_IndexRuotato_06',
% 'Y_IndexRuotato_07','Y_IndexRuotato_08','Y_IndexRuotato_09','Y_IndexRuotato_10','Z_IndexRuotato_01',
% 'Z_IndexRuotato_02','Z_IndexRuotato_03','Z_IndexRuotato_04','Z_IndexRuotato_05','Z_IndexRuotato_06',
% 'Z_IndexRuotato_07','Z_IndexRuotato_08','Z_IndexRuotato_09','Z_IndexRuotato_10','X_ThumbRuotato_01',
% 'X_ThumbRuotato_02','X_ThumbRuotato_03','X_ThumbRuotato_04','X_ThumbRuotato_05','X_ThumbRuotato_06',
% 'X_ThumbRuotato_07','X_ThumbRuotato_08','X_ThumbRuotato_09','X_ThumbRuotato_10','Y_ThumbRuotato_01',
% 'Y_ThumbRuotato_02','Y_ThumbRuotato_03','Y_ThumbRuotato_04','Y_ThumbRuotato_05','Y_ThumbRuotato_06',
% 'Y_ThumbRuotato_07','Y_ThumbRuotato_08','Y_ThumbRuotato_09','Y_ThumbRuotato_10','Z_ThumbRuotato_01',
% 'Z_ThumbRuotato_02','Z_ThumbRuotato_03','Z_ThumbRuotato_04','Z_ThumbRuotato_05','Z_ThumbRuotato_06',
% 'Z_ThumbRuotato_07','Z_ThumbRuotato_08','Z_ThumbRuotato_09','Z_ThumbRuotato_10','X_palmplane_01',
% 'X_palmplane_02','X_palmplane_03','X_palmplane_04','X_palmplane_05','X_palmplane_06','X_palmplane_07',
% 'X_palmplane_08','X_palmplane_09','X_palmplane_10','Y_palmplane_01','Y_palmplane_02','Y_palmplane_03',
% 'Y_palmplane_04','Y_palmplane_05','Y_palmplane_06','Y_palmplane_07','Y_palmplane_08','Y_palmplane_09',
% 'Y_palmplane_10','Z_palmplane_01','Z_palmplane_02','Z_palmplane_03','Z_palmplane_04','Z_palmplane_05',
% 'Z_palmplane_06','Z_palmplane_07','Z_palmplane_08','Z_palmplane_09','Z_palmplane_10 ','X_fingerrplane_01',
% 'X_fingerplane_02','X_fingerplane_03','X_fingerplane_04','X_fingerplane_05','X_fingerplane_06','X_fingerplane_07',
% 'X_fingerplane_08','X_fingerplane_09','X_fingerplane_10 ','Y_fingerplane_01','Y_fingerplane_02','Y_fingerplane_03',
% 'Y_fingerplane_04','Y_fingerplane_05','Y_fingerplane_06','Y_fingerplane_07','Y_fingerplane_08','Y_fingerplane_09',
% 'Y_fingerplane_10 ','Z_fingerplane_01','Z_fingerplane_02','Z_fingerplane_03','Z_fingerplane_04','Z_fingerplane_05',
% 'Z_fingerplane_06','Z_fingerplane_07','Z_fingerplane_08','Z_fingerplane_09','Z_fingerplane_10 ','X_fingerplaneR_01',
% 'X_fingerplaneR_02','X_fingerplaneR_03','X_fingerplaneR_04','X_fingerplaneR_05','X_fingerplaneR_06','X_fingerplaneR_07',
% 'X_fingerplaneR_08','X_fingerplaneR_09','X_fingerplaneR_10 ','Y_fingerplaneR_01','Y_fingerplaneR_02','Y_fingerplaneR_03',
% 'Y_fingerplaneR_04','Y_fingerplaneR_05','Y_fingerplaneR_06','Y_fingerplaneR_07','Y_fingerplaneR_08','Y_fingerplaneR_09',
% 'Y_fingerplaneR_10 ','Z_fingerplaneR_01','Z_fingerplaneR_02','Z_fingerplaneR_03','Z_fingerplaneR_04','Z_fingerplaneR_05',
% 'Z_fingerplaneR_06','Z_fingerplaneR_07','Z_fingerplaneR_08','Z_fingerplaneR_09','Z_fingerplaneR_10 ',' Elevation_01',' Elevation_02',
% ' Elevation_03',' Elevation_04',' Elevation_05',' Elevation_06',' Elevation_07',' Elevation_08',' Elevation_09',' Elevation_10',
% ' Azimut_01',' Azimut_02',' Azimut_03',' Azimut_04',' Azimut_05',' Azimut_06',' Azimut_07',' Azimut_08',' Azimut_09',' Azimut_10',
% 'MaxAccelNormal','MaxDecelNormal','ElevationPolso_01','ElevationPolso_02','ElevationPolso_03','ElevationPolso_04','ElevationPolso_05',
% 'ElevationPolso_06','ElevationPolso_07','ElevationPolso_08','ElevationPolso_09','ElevationPolso_10','AzimuthPolso_01','AzimuthPolso_02',
% 'AzimuthPolso_03','AzimuthPolso_04','AzimuthPolso_05','AzimuthPolso_06','AzimuthPolso_07','AzimuthPolso_08','AzimuthPolso_09','AzimuthPolso_10',
% 'LughezzaTraiettoriaPolso','LughezzaTraiettoriaPollice','LughezzaTraiettoriaIndice','Lvmax','wristVel_50ms','wristVel_50_100','wristVel_100_150','wristVel_150_200','VmaxAbs','T_ap_maxAbs';}];

% Output = F table as a cell.

% Atesh Koul
% Created 08/07/2014

% Important thing is to recursively select different features - (1,2),
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


% This is done as i will start from 1. Other way to do is to use i = 0:9
% but in that case, other indicies have to be i+1. It's simpler to have


% Pre allocating
featureLar = cell(1,10);
featureSma = cell(1,10);
F_all = cell(1,10);

for i = 1:1
    
    % Separate positive and negative instances of the features at a time 
    % point 
    featureLar{i} = Data1
    featureSma{i} = Data2
    
    % calculate Mean values of positive and negative features
    meanFeatLar= mean(featureLar{1,i});
    meanFeatSma= mean(featureSma{1,i});
     
    % create bigger matrix for calculating covariance (depending on what 
    % set of features chosen)
    SSma = featureSma{1,i};
    SLar = featureLar{1,i};
     
    %SSma = featureLar-meanFeatLar
     
    for j = 1:10
        % The combination will have to be always 12 features, what is
        % changing is the no. of the features to be taken at a time:
        % determined by the j parameter in featMatrix = nchoosek(1:12,j);
        featMatrix = nchoosek(1:10,j);
        
        % Alternate way might be using permutations, but that would lead to
        % a lot of repetition and is not advisable for numbers >10 (which 
        % is our case).
        %featMatrix = perms(1:j);
        featMatrixCheck{j} = featMatrix;
        
        for k=1:size(featMatrix,1)
            meanFeatSetLar = meanFeatLar(featMatrix(k,:));
            meanFeatSetSma = meanFeatSma(featMatrix(k,:));
            SFeatSetSSma=SSma(:,featMatrix(k,:));
            SFeatSetSLar=SLar(:,featMatrix(k,:));
            F(k,j) = (norm(meanFeatSetLar-meanFeatSetSma)).^2./(trace(cov(SFeatSetSLar))+trace(cov(SFeatSetSSma)));
            peppa = trace(cov(SFeatSetSLar))-sum(var(SFeatSetSLar));
            poppa = trace(cov(SFeatSetSSma))-sum(var(SFeatSetSSma));
            check{j,k} = [peppa poppa];
            check2{j,k}= [size(cov((SFeatSetSLar))) size(cov((SFeatSetSLar)))];
            
        end
%         
        for l=1:10
            % arrange the matrix in the format for Feature 
            % Row 1 F1 : (1feature (F1 in this case)) (2 features)
            % (3 features)
            % Row 2 F2 : (1feature (F2 in this case)) (2 features)
            % (3 features)
            index = logical(sum(featMatrix==l,2));
            tmp = F(:,j);
            F_arrange{l,j}=tmp(index)';
        end

Check{i}=check
Check2{i}=check2
     end     
     F_all{i}=F_arrange;
end


for pop = 1:size(Check{1,1},1)
    for pep = 1:size(Check{1,1},2)
        a = sum((Check{1,1}{pop,pep}>0.000001));
        ne(pop,pep) =a;
    if any(a==1)
        sprintf('error')
    else
        %sprintf('go!')
    end
    end


end






% Alternate Implimentation
% initial_col = [8 18 40 50 60 70 80 90 100 170 180 190];
% 
% % This is done as i will start from 1. Other way to do is to use i = 0:9
% % but in that case, other indicies have to be i+1. It's simpler to have
% % initial_col to be initial_col-1
% initial_col = initial_col -1;
% 
% 
% % Pre allocating
% featureLar = cell(1,10);
% featureSma = cell(1,10);
% F_all = cell(1,10);
% 
% for i = 1:10
%      featureLar{i} = Data(Data(:,2)==2,initial_col+i);     
%      featureSma{i} = Data(Data(:,2)==1,initial_col+i);
%      meanFeatLar= mean(featureLar{1,i});
%      meanFeatSma= mean(featureSma{1,i});
%      
%      nTrialsSma = sum(Data(:,2)==1);
%      nTrialsLar = sum(Data(:,2)==2);
%      
%      
%      SLar = (1./(nTrialsLar-1)).*sum((featureLar{1,i}-repmat(meanFeatLar,size(featureLar{1,i},1),1)).^2);
%      SSma = (1./(nTrialsSma-1)).*sum((featureSma{1,i}-repmat(meanFeatSma,size(featureSma{1,i},1),1)).^2);
%      
%      
%      for j = 1:12
%          % The combination will have to be always 12 features, what is
%          % changing is the no. of the features to be taken at a time:
%          % determined by the j parameter in featMatrix = nchoosek(1:12,j);
%          featMatrix = nchoosek(1:12,j);
%          %featMatrix = perms(1:j);
%          featMatrixCheck{i} = featMatrix;
%             for k=1:size(featMatrix,1)
%                 meanFeatSetLar = meanFeatLar(featMatrix(k,:));
%                 meanFeatSetSma = meanFeatSma(featMatrix(k,:));
%                 SFeatSetSSma=SSma(featMatrix(k,:));
%                 SFeatSetSLar=SLar(featMatrix(k,:));
%                 F(k,j) = sum((meanFeatSetLar-meanFeatSetSma).^2)./sum((SFeatSetSLar+SFeatSetSSma));
%             end
%             
%         for l=1:12
%             % arrange the matrix in the format for Feature 
%             % Row 1 F1 : (1feature (F1 in this case)) (2 features)
%             % (3 features)
%             % Row 2 F2 : (1feature (F2 in this case)) (2 features)
%             % (3 features)
%             index = logical(sum(featMatrix==l,2));
%             tmp = F(:,j);
%             F_arrange{l,j}=tmp(index)';
%         end
%      end     
%      F_all{i}=F_arrange;
% end