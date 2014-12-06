% Script to fix the issue of normality: the data is first interpolated
% subject wise, the outliers based on the group are then calculated, the
% data subject wise is verified for these outliers, removed, in case the
% outlier is the first time point, it's substituted for the average subject
% value. The data is then interpolated again. This is to fill the missing
% value without substituting mean values for all outliers. (which would 
% decrease variance and effect the calculation of F-score based on Yuan 
% paper. )

[merg,sub]=interpol_kin;
mergData = cat(1,merg{:});

origSub = sub;
Data = mergData;
sub = sub(:,1:2);

% Finding and substituting group outliers.
featLar = Data(Data(:,2)==2,:);
featSma = Data(Data(:,2)==1,:);

upLimFeatSma = mean(featSma)+2.*std(featSma);
lowLimFeatSma = mean(featSma)-2.*std(featSma);

upLimFeatLar = mean(featLar)+2.*std(featLar);
lowLimFeatLar = mean(featLar)-2.*std(featLar);

upLimFeat = [upLimFeatSma;upLimFeatLar];
lowLimFeat = [ lowLimFeatSma;lowLimFeatLar];

% for number of subjects
for i = 1:15
    % for number of objects
    for j = 1:2
        DataSub = sub{i,j};
        %trials = size(Data,1);
        upLim = upLimFeat(j,:);
        lowLim = lowLimFeat(j,:);
        for k = 3:251
            if any(DataSub(:,k)>(upLim(k)) | DataSub(:,k)<(lowLim(k)))
                a = find(DataSub(:,k)>(upLim(k)) | DataSub(:,k)<(lowLim(k)));
                DataSub(a,k)=NaN;   
            end
            sub{i,j}=DataSub;
        end
    end
end


% Check if the first values of variables are NaN
for i =1:15
    for j = 1:2
        Data = sub{i,j}(:,[8:27 40:109 170:199]);
        check{i,j}=Data;
        for k = 1:120
            if any(isnan(Data(:,k)))
                % Substitute with mean value
                Data(isnan(Data(:,k)),k)=nanmean(Data(:,k),1);
            end
          
            sub{i,j}(:,[8:27 40:109 170:199]) = Data;
        end
    end
end

for i =1:15
    for j=1:2
        if (any(sum(isnan(check{i,j}))==size(check{i,j},1)))
            sub{i,j}=[];
        end
           
    end
end 




% % Check if the first values of variables are NaN
% for i =1:15
%     for j = 1:2
%         Data = sub{i,j}(:,[8 18 40 50 60 70 80 90 100 170 180 190]);
%         check{i,j}=Data;
%         for k = 1:12
%             if any(isnan(Data(:,k)))
%                 % Substitute with mean value
%                 Data(isnan(Data(:,k)),k)=nanmean(Data(:,k),1);
%             end          
%             sub{i,j}(:,[8 18 40 50 60 70 80 90 100 170 180 190]) = Data;
%         end
%     end
% end
% 
% 
% 
% for i=1:15
%     for j = 1:2
%         reInterpolData = sub{i,j};
%         rep_nan1 = inpaint_nans(reInterpolData(:,8:17));
%         rep_nan2 = inpaint_nans(reInterpolData(:,18:27));
%         rep_nan3 = inpaint_nans(reInterpolData(:,40:49));
%         rep_nan4 = inpaint_nans(reInterpolData(:,50:59));
%         rep_nan5 = inpaint_nans(reInterpolData(:,60:69));
%         rep_nan6 = inpaint_nans(reInterpolData(:,70:79));
%         rep_nan7 = inpaint_nans(reInterpolData(:,80:89));
%         rep_nan8 = inpaint_nans(reInterpolData(:,90:99));
%         rep_nan9 = inpaint_nans(reInterpolData(:,100:109));
%         rep_nan10 = inpaint_nans(reInterpolData(:,110:119));
%         rep_nan11 = inpaint_nans(reInterpolData(:,120:129));
%         rep_nan12 = inpaint_nans(reInterpolData(:,130:139));
%         rep_nan13 = inpaint_nans(reInterpolData(:,140:149));
%         rep_nan14 = inpaint_nans(reInterpolData(:,150:159));
%         rep_nan15 = inpaint_nans(reInterpolData(:,160:169));
%         rep_nan16 = inpaint_nans(reInterpolData(:,170:179));
%         rep_nan17 = inpaint_nans(reInterpolData(:,180:189));
%         rep_nan18 = inpaint_nans(reInterpolData(:,190:199));
%         rep_nan19 = inpaint_nans(reInterpolData(:,200:209));
%         rep_nan20 = inpaint_nans(reInterpolData(:,210:219));
%         rep_nan21 = inpaint_nans(reInterpolData(:,222:231));
%         rep_nan22 = inpaint_nans(reInterpolData(:,232:241));
%         
%         % interpolate using all the trials of the same type
%         %intp_nan1 = inpaint_nans(rep_nan1);
%         %intp_nan2 = inpaint_nans(rep_nan2);
%         
% 
%         
%         reInterpolData(:,8:17) = rep_nan1;
%         reInterpolData(:,18:27) = rep_nan2;
%         reInterpolData(:,40:49) = rep_nan3;
%         reInterpolData(:,50:59) = rep_nan4;
%         reInterpolData(:,60:69) = rep_nan5;
%         reInterpolData(:,70:79) = rep_nan6;
%         reInterpolData(:,80:89) = rep_nan7;
%         reInterpolData(:,90:99) = rep_nan8;
%         reInterpolData(:,100:109) = rep_nan9;
%         reInterpolData(:,110:119) = rep_nan10;
%         reInterpolData(:,120:129) = rep_nan11;
%         reInterpolData(:,130:139) = rep_nan12;
%         reInterpolData(:,140:149) = rep_nan13;
%         reInterpolData(:,150:159) = rep_nan14;        
%         reInterpolData(:,160:169) = rep_nan15;
%         reInterpolData(:,170:179) = rep_nan16;
%         reInterpolData(:,180:189) = rep_nan17;
%         reInterpolData(:,190:199) = rep_nan18;
%         reInterpolData(:,200:209) = rep_nan19;
%         reInterpolData(:,210:219) = rep_nan20;
%         reInterpolData(:,222:231) = rep_nan21;
%         reInterpolData(:,232:241) = rep_nan22;
%         sub{i,j}=reInterpolData;
%     end
% end



for i =1:15
peppa{i} = cat(1,sub{i,1:2});
peppa{i}=sortrows(peppa{i});
end

fullData = cat(1,peppa{:});



for k = 1:2
    feat = fullData(fullData(:,2)==k,[8:27 40:109 170:199]);
    
    for i=1:10:120
        featData = feat(:,i:i+9);
        for j = 1:size(featData,1)
            if any(isnan(featData(j,:)))
                featData(j,:)= inpaint_nans(featData(j,:));
            end
        end
        interpFeat{k}(:,i:i+9) = featData;        
    end    
end

           


% Andrea's Approach: Might have an issue of 'creating data' to fill missing
% values.
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


clear i j;

rng('default')

for i = 1:2
for j=1:120
    upValue = nanmean(X_norm{i}(:,j))+nanstd(X_norm{i}(:,j));
    lowValue = nanmean(X_norm{i}(:,j))-nanstd(X_norm{i}(:,j));
    
    
    X_norm{i}(find(isnan(X_norm{i}(:,j))),j) = lowValue + (upValue-lowValue).*rand(size(find(isnan(X_norm{i}(:,j))),1),1);
    
end
end

    
fullData = [ ones(size(X_norm{1,1},1),1) X_norm{1,1}; 2.*ones(size(X_norm{1,2},1),1) X_norm{1,2}];








% Yuan Method


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


clear i j;





for i = 1:2
    pop = NaN(size(X_norm{i},1),120);
    for j = 1:120
        
        pop(1:size(X_norm{i}(~isnan(X_norm{i}(:,j)),1)),j) = X_norm{i}(~isnan(X_norm{i}(:,j)),j);
        
    end
    X_new{i}=pop;
end



smaMaxNan = max(sum(isnan(X_norm{1})));
larMaxNan = max(sum(isnan(X_norm{2})));

nonNanSma = size(X_norm{1},1)-smaMaxNan;
nonNanLar = size(X_norm{2},1)-larMaxNan;

for j = 1:120
        comSmaSeq = randperm(size(X_new{1}(~isnan(X_new{1}(:,j))),1),nonNanSma);
        comSmaData(:,j) = X_new{1}(comSmaSeq,j);
end


for j = 1:120
        comLarSeq = randperm(size(X_new{2}(~isnan(X_new{2}(:,j))),1),nonNanLar);
        comLarData(:,j) = X_new{2}(comLarSeq,j);
end
 


 fullData = [ ones(size(comSmaData,1),1) comSmaData; 2.*ones(size(comLarData,1),1) comLarData];










