function [labels,instance_num] = get_indv_res( score_file_name )
    % Initialization
    classes = {'E', 'S', 'V', 'M', 'L', 'X', '-1'};
    class_num = size(classes,2);
    
    % Open file and read in scores
    fid = fopen(score_file_name);
    if fid == -1
        labels = [];
        instance_num = 0;
        return;
    else
        instance_num = fscanf(fid,'%d',1);
        scores = fscanf(fid,'%f %f %f %f %f %f %f ');
        scores = reshape(scores',class_num,instance_num);
        scores = scores';
        %scores = textscan(fid,'%f %f %f %f %f %f %f ');
    end
    fclose(fid);
    
    % Assign labels
    labels = cell(instance_num,1);
    for j = 1:instance_num
        [~,ind] = max(scores(j,:));
        labels(j) = classes(ind);
    end
end

