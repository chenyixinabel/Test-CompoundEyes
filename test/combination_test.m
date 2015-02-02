all_det_num = 7;
category_num = 24;
all_data_path = '~/tmp/Test_s_1.0_p_0.5'; % Do not end with '/' %
all_save_path = '~/tmp/Test_combine/';

save_file_name = 'combine_s_1d0_p_0d5.mat';
save_loc = '~/Dropbox/MyProject/Code_Data/matlab/';
save_cmd = strcat('save(','''',save_loc,save_file_name,'''',',','''','avg_ac_mat','''',',','''','avg_map_mat','''',',',...
    '''','plus_ac_mat','''',',','''','plus_map_mat','''',',','''','minus_ac_mat','''',',','''','minus_map_mat','''',',',...
    '''','max_ac_idx_mat','''',',','''','min_ac_idx_mat','''',',','''','max_map_idx_mat','''',',','''','min_map_idx_mat','''',')');

avg_ac_mat = [];
avg_map_mat = [];
plus_ac_mat = [];
plus_map_mat = [];
minus_ac_mat = [];
minus_map_mat = [];

max_ac_idx_mat = [];
min_ac_idx_mat = [];
max_map_idx_mat = [];
min_map_idx_mat = [];

mk_cmd = strcat('mkdir', {' '}, all_save_path);
chmod_cmd_1 = strcat('chmod', {' '}, '-R', {' '}, '777', {' '}, all_save_path);
system(mk_cmd{1});
system(chmod_cmd_1{1});

for j = 1:6
    data_path = strcat(all_save_path, num2str(j), '/');
    [avg_ac,plus_ac,minus_ac,avg_map,plus_map,minus_map,max_ac_idx,min_ac_idx,max_map_idx,min_map_idx] = combine_setup(all_det_num, j,...
        category_num, all_data_path, data_path);
    avg_ac_mat(end+1) = avg_ac;
    plus_ac_mat(end+1) = plus_ac;
    minus_ac_mat(end+1) = minus_ac;
    avg_map_mat(end+1) = avg_map;
    plus_map_mat(end+1) = plus_map;
    minus_map_mat(end+1) = minus_map;
    max_ac_idx_mat(end+1) = max_ac_idx;
    min_ac_idx_mat(end+1) = min_ac_idx;
    max_map_idx_mat(end+1) = max_map_idx;
    min_map_idx_mat(end+1) = min_map_idx;
end

eval(save_cmd);