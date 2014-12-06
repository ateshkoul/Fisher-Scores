
% script to substitute mean values in place of missing NaNs 
% This is necessiated by the fact that the origional distribution was not
% gaussian and we had to remove outliers based on the z score of the data
% values. The removal of outliers would lead to missing values and the code
% for Fisher values or in general the combined F-score cannot be
% calculated.

% This is one approach to do it. The other options are to remove rows with
% even a single NaN- no NaN at all and to interpolate.

% The problem with removing all NaNs is that it will leave us with very few
% examples (around 280 trials will be removed)

% The problem with interpolation is that the interpolation will not make
% sense as the data is joined from different subjects. The interpolation
% should ideally be at the subject level

% The problem with this approach is that it will replace 20-30 values in a
% variable (~ 8-9%) with mean values.
nan_mat = [1 11 21 31 41 51 61 71 81 91 101 111];

        for k=1:size(nan_mat,2)
        if any(isnan(obj{j}(:,nan_mat(k))))
            obj{j}(isnan(obj{j}(:,nan_mat(k))),nan_mat(k))= nanmean(obj{j}(:,nan_mat(k)),1);
        end
        end  
        
        
        for i=1:120
            if any(isnan(a(:,i)))
                a(isnan(a(:,i)),i)=nanmean(a(:,i),1);
            end
        end