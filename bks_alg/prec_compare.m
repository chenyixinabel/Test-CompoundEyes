function [all_acs,all_maps,all_precs,all_recs,all_fs,postp_times,instance_num,prep_times] = prec_compare( scores_folder, gt_test_file_name, gt_trn_file_name, results_file )
    % Initialization
    detector_num = length(dir(strcat(scores_folder,'*.txt')));
    finfo = dir(strcat(scores_folder,'*.txt'));
    gt_test_file_id = fopen(gt_test_file_name);
    gt_test = textscan(gt_test_file_id,'%d %s %s');
    gt_test = gt_test{2};
    fclose(gt_test_file_id);
    
    % Compute precisions of each detector
    all_acs = zeros(detector_num+1,1);
    all_maps = zeros(detector_num+1,1);
    all_precs = zeros(detector_num+1,1);
    all_recs = zeros(detector_num+1,1);
    all_fs = zeros(detector_num+1,1);
    postp_times = zeros(detector_num+1,1);
    
    for j = 1:detector_num
        fname = finfo(j).name;
        tic;
        [labels,test_ins_num] = get_indv_res(strcat(scores_folder,fname));
        postp_times(j) = toc;
        if size(labels,1) ~= size(gt_test,1)
            all_acs = [];
            all_maps = [];
            all_precs = [];
            all_recs = [];
            all_fs = [];
            return;
        else
            all_acs(j) = comp_ac(labels,gt_test);
            all_maps(j) = comp_ap(labels,gt_test);
            [all_precs(j),all_recs(j),all_fs(j)] = comp_prf(labels,gt_test);
        end
    end
    
    % Compute the precision of posterior probability classifier
    tic;
    labels = post_prob_boost(scores_folder);
    postp_times(end,1) = toc;
    all_acs(end,1) = comp_ac(labels,gt_test);
    all_maps(end,1) = comp_ap(labels,gt_test);
    [all_precs(end,1),all_recs(end,1),all_fs(end,1)] = comp_prf(labels,gt_test);
    
    % Compute the number of training instances
    gt_trn_file_id = fopen(gt_trn_file_name);
    %trn_ins_num = numel(textread(gt_trn_file_name,'%1c%*[^\n]'));
    gt_trn_cell = textscan(gt_trn_file_id, '%d %s %s\n');
    fclose(gt_trn_file_id);
    trn_ins_num = size(gt_trn_cell{1}, 1);
    instance_num = cat(1,test_ins_num,trn_ins_num);
    
    % Extract pre-processing times
    prep_times = get_runtime(results_file);
end

function ac = comp_ac(labels, gt)
    correct = 0;
    for k = 1:size(labels,1)
        %         if strcmp(gt{k},'X') == 1 || strcmp(gt{k},'-1') == 1
        %             if strcmp(labels{k},'X') == 1 || strcmp(labels{k},'-1') == 1
        %                 correct = correct + 1;
        %             end
        %         else
        %             if strcmp(labels{k},'X') == 0 && strcmp(labels{k},'-1') == 0
        %                 correct = correct + 1;
        %             end
        %         end
        if strcmp(labels{k},gt{k}) == 1
            correct = correct + 1;
        end
    end
    ac = correct/size(labels,1);
end

function ap = comp_ap(labels, gt)
    rel = 0;
    correct = 0;
    rel_vec = [];
    for k = 1:size(labels,1)
        if strcmp(labels{k},'X') == 0 && strcmp(labels{k},'-1') == 0
            rel = rel + 1;
            if strcmp(gt{k},'X') == 0 && strcmp(gt{k},'-1') == 0
                correct = correct + 1;
                rel_vec = cat(1,rel_vec,correct/rel);
            end
        end
    end
    if correct == 0
        if sum(rel_vec) == 0
            ap = 1;
        else
            ap = 0;
        end
    else
        ap = sum(rel_vec)/correct;
    end
end

function [precision, recall, fscore] = comp_prf(labels, gt)
    tp = 0;
    fn = 0;
    fp = 0;
    for k = 1:size(labels,1)
        if strcmp(labels{k},'X') == 0 && strcmp(labels{k},'-1') == 0
            if strcmp(gt{k},'X') == 0 && strcmp(gt{k},'-1') == 0
                tp = tp + 1;
            else
                fn = fn + 1;
            end
        else
            if strcmp(gt{k},'X') == 0 && strcmp(gt{k},'-1') == 0
                fp = fp + 1;
            end
        end
    end
    
    if tp+fp == 0
        if tp == 0
            precision = 1;
        else
            precision = 0;
        end
    else
        precision = tp/(tp+fp);
    end
    
    if tp+fn == 0
        if tp == 0
            recall = 1;
        else
            recall = 0;
        end
    else
        recall = tp/(tp+fn);
    end
    
    if precision ~= 0 || recall ~= 0
        fscore = (2*precision*recall)/(precision+recall);
    else
        fscore = 0;
    end
end

function runtime_mat = get_runtime(results_file)
%     detector_num = 7;
%     sidx = [5,1,4,2,7,3,6];
%     data_per_detector = 3;
%     runtime_mat = zeros(detector_num,data_per_detector);
    data_num = 4;
    runtime_mat = zeros(1,data_num);
    
    text = fileread(results_file);
    %expr = ':\s([\d]+.[\d]+)s';
    expr = 'is[:]*\s([\d]+.[\d]+)';
    out = regexp(text,expr,'tokens');
    
    % Extract numbers %
    %if size(out,2) ~= data_per_detector*detector_num
    if size(out,2) ~= data_num
        runtime_mat = [];
        return;
    else
%         for j = 1:detector_num
%             runtime_mat(j,1) = str2double(out{(j-1)*3+1}{1});
%             runtime_mat(j,2) = str2double(out{(j-1)*3+2}{1});
%             runtime_mat(j,3) = str2double(out{j*3}{1});
%         end
        runtime_mat(1,1) = str2double(out{1}{1});
        runtime_mat(1,2) = str2double(out{2}{1});
        runtime_mat(1,3) = str2double(out{3}{1});
        runtime_mat(1,4) = str2double(out{4}{1});
    end
    
    % Shffule runtime_mat, in conform with the order of accuracy matrices %
    %runtime_mat = runtime_mat(sidx,:);
end

% label option should be from 'E','S','V','M','L','X','-1'
% function [labels_ret,gts_ret] = filter_by_gt(labels_ori,gts_ori,label_option)
%     labels_ret = {};
%     gts_ret = {};
%     for k = 1:size(labels_ori,1)
%         if strcmp(gts_ori{k},label_option) == 1
%             labels_ret = cat(1,labels_ret,labels_ori(k));
%             gts_ret = cat(1,gts_ret,gts_ori(k));
%         elseif strcmp(label_option,'X') == 1 || strcmp(label_option,'-1') == 1
%             if strcmp(gts_ori{k},'X') == 1 || strcmp(gts_ori{k},'-1') == 1
%                 labels_ret = cat(1,labels_ret,labels_ori(k));
%                 gts_ret = cat(1,gts_ret,gts_ori(k));
%             end
%         end
%     end
% end