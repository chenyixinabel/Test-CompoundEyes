function [post_probs,instance_num] = collect_scores( scores_folder,class_num )
    prob_mini = 0.001;
    detector_num = length(dir(strcat(scores_folder,'*.txt')));
    finfo = dir(strcat(scores_folder,'*.txt'));
    scores_set = [];
    
    % Read all probabilities of all detectors into scores_set
    for j = 1:detector_num
        fname = finfo(j).name;
        fid = fopen(strcat(scores_folder,fname));
        if fid == -1
            instance_num = 0;
            return;
        else
            instance_num = fscanf(fid,'%d',1);
            %scores = fscanf(fid,'%f %f %f %f %f %f %f ',[instance_num,class_num]);
            scores = fscanf(fid,'%f %f %f %f %f %f %f ');
            scores = reshape(scores',class_num,instance_num);
            scores = scores';
            if j == 1
                scores_set = zeros(instance_num,class_num,detector_num);
            end
            % Increasing items of value 0 by 0.001, the increase amount is
            % deduced from the maximum value
            for s = 1:size(scores,1)
                [~,ind] = max(scores(s,:));
                for t = 1:size(scores,2)
                    if scores(s,t) < prob_mini
                        scores(s,t) = prob_mini;
                        scores(s,ind) = scores(s,ind) - prob_mini;
                    end
                end
            end
            scores_set(:,:,j) = scores;
        end
        fclose(fid);
    end
    
    % Compute the posterior probabilities and determine labels 
    scores_set = permute(scores_set,[2,3,1]);
    post_probs = zeros(instance_num,class_num);
    for j = 1:instance_num
        prod_vec = prod(scores_set(:,:,j),2);
        post_probs(j,:) = (prod_vec/sum(prod_vec))';
    end
end

