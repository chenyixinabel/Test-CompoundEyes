% data_loc is the location of dataset, which ends with "/", set_num is the
% number attached with an individual set, which ranges from 1 to 24.
function [acs,maps,precs,recs,fs,postp_times,instance_num,prep_times] = bks( data_loc, set_num )
    scores_file = strcat(data_loc, 'Test_v', num2str(set_num), '/inter_save/Label_files/');
    gt_test_file_name = strcat(data_loc, 'Test_v', num2str(set_num), '/groundtruth/GT_new_', num2str(set_num), '_test.txt');
    gt_trn_file_name = strcat(data_loc, 'Test_v', num2str(set_num), '/groundtruth/GT_new_', num2str(set_num), '_train.txt');
    results_file = strcat(data_loc, 'Test_v', num2str(set_num), '/inter_save/results.txt');
    [acs,maps,precs,recs,fs,postp_times,instance_num,prep_times] = prec_compare(scores_file,gt_test_file_name,gt_trn_file_name,results_file);
end

