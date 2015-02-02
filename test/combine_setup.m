function [avg_ac,plus_ac,minus_ac,avg_map,plus_map,minus_map,max_ac_idx,min_ac_idx,max_map_idx,min_map_idx] = combine_setup(all_det_num, det_num,...
    category_num, all_data_path, all_save_path)
    %all_det_num = 7;
    count_range = 1:all_det_num;
    %det_num = 2; % The number of detectors been reduced
    count_mat = int16(combnk(count_range, det_num));
    %category_num = 24;

    all_ac_mat = zeros(size(count_mat,1),1);
    all_map_mat = zeros(size(count_mat,1),1);

    %all_data_path = '~/tmp/Test_s_1.0_p_0.5'; % Do not end with '/' %
    %all_save_path = '~/tmp/Test_combine/';

    locs = strfind(all_data_path, '/');
    folder_name = all_data_path(locs(end)+1:end);

    mk_cmd = strcat('mkdir', {' '}, all_save_path);
    chmod_cmd_1 = strcat('chmod', {' '}, '-R', {' '}, '777', {' '}, all_save_path);
    system(mk_cmd{1});
    system(chmod_cmd_1{1});

    old_path = strcat(all_save_path, folder_name);
    for j = 1:size(count_mat, 1)
        new_path = strcat(all_save_path, num2str(det_num), '_', num2str(j));
        cp_cmd = strcat('cp', {' '}, '-r', {' '}, all_data_path, '/', {' '}, all_save_path);
        rename_cmd = strcat('mv', {' '}, old_path, {' '}, new_path);
        chmod_cmd_2 = strcat('chmod', {' '}, '-R', {' '}, '777', {' '}, new_path);
        system(cp_cmd{1});
        system(rename_cmd{1});
        system(chmod_cmd_2{1});

        for k = 1:category_num
            scores_folder = strcat(new_path, '/Test_v', num2str(k), '/inter_save/Label_files/');
            finfo = dir(strcat(scores_folder,'*.txt'));
            for t = 1:size(count_mat, 2)
                file_name = strcat(scores_folder, finfo(count_mat(j,t)).name);
                del_cmd = strcat('rm', {' '}, file_name);
                system(del_cmd{1});
            end
        end

        [ac_mat, map_mat, ~, ~] = test_combine(all_det_num-det_num, strcat(new_path,'/'));
        all_ac_mat(j) = mean(ac_mat(end,:));
        all_map_mat(j) = mean(map_mat(end,:));
    end

    avg_ac = mean(all_ac_mat);
    avg_map = mean(all_map_mat);
    [max_ac, max_ac_idx] = max(all_ac_mat);
    [min_ac, min_ac_idx] = min(all_ac_mat);
    [max_map, max_map_idx] = max(all_map_mat);
    [min_map, min_map_idx] = min(all_map_mat);
    plus_ac = max_ac - avg_ac;
    plus_map = max_map - avg_map;
    minus_ac = avg_ac - min_ac;
    minus_map = avg_map - min_map;
end