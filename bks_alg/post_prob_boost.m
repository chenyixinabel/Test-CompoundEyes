% It is required that scores_folder ends with '/'
function labels = post_prob_boost( scores_folder )
    % Initialization
    classes = {'E', 'S', 'V', 'M', 'L', 'X', '-1'};
    class_num = size(classes,2);
    
    [post_probs,instance_num] = collect_scores(scores_folder,class_num);
    labels = cell(instance_num,1);
    for j = 1:instance_num
        [~,ind] = max(post_probs(j,:));
        labels(j) = classes(ind);
    end
end

