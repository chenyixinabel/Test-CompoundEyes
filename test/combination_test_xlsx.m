data_loc = 'e:\Dropbox\MyProject\Code_Data\matlab\';
result_name = 'combine_s_1d0_p_0d5';
tab_name_cell = {'avg_ac_mat','avg_map_mat','plus_ac_mat','plus_map_mat','minus_ac_mat','minus_map_mat','max_ac_idx_mat','min_ac_idx_mat',...
    'max_map_idx_mat', 'min_map_idx_mat'};

mat2xlsx(data_loc, result_name, tab_name_cell);