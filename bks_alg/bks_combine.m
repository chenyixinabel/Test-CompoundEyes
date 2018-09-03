%data_loc = '~/dataset/Test_s_1.0_p_0.5/';
save_loc = '~/dataset/CC_WEB_VIDEO/results/';
detector_num = 7;
category_num = 24;
data_loc = '~/dataset/CC_WEB_VIDEO/Test_s_0.1_p_0.5/';
%save_loc = 'e:\Dropbox\MyProject\Code_Data\matlab\';
save_file_name = 's_0.1_p_0.5.mat';
save_cmd = strcat('save(','''',save_loc,save_file_name,'''',',','''','ac_mat','''',',','''','map_mat','''',',',...
    '''','prec_mat','''',',','''','rec_mat','''',',','''','fs_mat','''',',','''','instance_nums','''',',',...
    '''','avg_stage_times','''',',','''','all_time','''',',','''','avg_all_time','''',',','''','avg_pre_proc_time',...
    '''',',','''','avg_proc_time','''',')');

ac_mat = zeros(detector_num+1, category_num);
map_mat = zeros(detector_num+1, category_num);
prec_mat = zeros(detector_num+1, category_num);
rec_mat = zeros(detector_num+1, category_num);
fs_mat = zeros(detector_num+1, category_num);
%time_mat = zeros(detector_num+1, category_num);
% The first row is the number of testing instances, the second one is that
% of training instances
instance_nums = zeros(2,category_num);
% qy_comp_hist_times = zeros(detector_num,category_num);
% avg_qy_comp_hist_times = zeros(detector_num,category_num);
% trn_comp_hist_times = zeros(detector_num,category_num);
% avg_trn_comp_hist_times = zeros(detector_num,category_num);
% sl_times = zeros(detector_num,category_num);
% avg_sl_times = zeros(detector_num,category_num);
% cla_times = zeros(detector_num,category_num);
% avg_cla_times = zeros(detector_num,category_num);
% comb_times = zeros(1,category_num);
% avg_comb_times = zeros(1,category_num);
% avg_stage_times = zeros(detector_num,4);
trn_comp_hist_times = zeros(1,category_num);
avg_trn_comp_hist_times = zeros(1,category_num);
qy_comp_hist_times = zeros(1,category_num);
avg_qy_comp_hist_times = zeros(1,category_num);
ins_times = zeros(1,category_num);
avg_ins_times = zeros(1,category_num);
resp_times = zeros(1,category_num);
avg_resp_times = zeros(1,category_num);
comb_times = zeros(1,category_num);
avg_comb_times = zeros(1,category_num);
avg_stage_times = zeros(1,4);
all_time = 0;
avg_all_time = 0;

% should be from 1 to category_num
for j = 1:category_num
    postp_times = zeros(detector_num+1,1);
    prep_times = zeros(detector_num,3);
    [ac_mat(:,j),map_mat(:,j),prec_mat(:,j),rec_mat(:,j),fs_mat(:,j),postp_times,instance_nums(:,j),prep_times] = bks(data_loc, j);
%     qy_comp_hist_times(:,j) = prep_times(:,1);
%     avg_qy_comp_hist_times(:,j) = prep_times(:,1)/instance_nums(1,j);
%     trn_comp_hist_times(:,j) = prep_times(:,2);
%     avg_trn_comp_hist_times(:,j) = prep_times(:,2)/instance_nums(2,j);
%     sl_times(:,j) = prep_times(:,3);
%     avg_sl_times(:,j) = prep_times(:,3)/instance_nums(1,j);
%     cla_times(:,j) = postp_times(1:end-1);
%     avg_cla_times(:,j) = postp_times(1:end-1)/instance_nums(1,j);
%     comb_times(j) = postp_times(end);
%     avg_comb_times(j) = postp_times(end)/instance_nums(1,j);
    trn_comp_hist_times(j) = prep_times(1);
    qy_comp_hist_times(j) = prep_times(2);
    ins_times(j) = prep_times(3);
    resp_times(j) = prep_times(4);
    avg_trn_comp_hist_times(j) = prep_times(1)/instance_nums(2,j);
    avg_qy_comp_hist_times(j) = prep_times(2)/instance_nums(1,j);
    avg_ins_times(j) = prep_times(3)/instance_nums(2,j);
    avg_resp_times(j) = prep_times(4)/instance_nums(1,j);
    comb_times(j) = postp_times(end);
    avg_comb_times(j) = postp_times(end)/instance_nums(1,j);
end

% for k = 1:detector_num
%     avg_stage_times(k,1) = mean(avg_qy_comp_hist_times(k,:));
%     avg_stage_times(k,2) = mean(avg_trn_comp_hist_times(k,:));
%     avg_stage_times(k,3) = mean(avg_sl_times(k,:));
%     avg_stage_times(k,4) = mean(avg_cla_times(k,:));
% end
% avg_all_time = max(avg_stage_times(:,1)+avg_stage_times(:,2)+avg_stage_times(:,3)+avg_stage_times(:,4))+mean(avg_comb_times);
% all_time = max(mean(qy_comp_hist_times+trn_comp_hist_times+sl_times+cla_times,2))+mean(comb_times);
% eval(save_cmd);
avg_stage_times(1) = mean(avg_qy_comp_hist_times);
avg_stage_times(2) = mean(avg_trn_comp_hist_times);
avg_stage_times(3) = mean(avg_ins_times);
avg_stage_times(4) = mean(avg_resp_times);
all_time = sum(qy_comp_hist_times+trn_comp_hist_times+ins_times+resp_times+comb_times);
%avg_all_time = all_time/sum(sum(instance_nums));
avg_all_time = mean(avg_trn_comp_hist_times+avg_ins_times+avg_qy_comp_hist_times+avg_resp_times+avg_comb_times);
avg_pre_proc_time = mean(avg_trn_comp_hist_times+avg_ins_times+avg_qy_comp_hist_times);
avg_proc_time = mean(avg_resp_times+avg_comb_times);
eval(save_cmd);