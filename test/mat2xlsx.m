% data_loc = 'e:\Dropbox\MyProject\Code_Data\matlab\';
% result_name = 'results_p7d5';
% tab_name_cell = {'avg_ac_mat','avg_map_mat','avg_prec_mat','avg_rec_mat','avg_fs_mat','instance_nums','avg_stage_times','all_time','avg_all_time'};
% alphbet_cell = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
% 
% mat_name = strcat(data_loc,result_name,'.mat');
% xlsx_name = strcat(data_loc,result_name,'.xlsx');
% 
% % Load results file
% load_cmd = strcat('load',{' '},mat_name);
% eval(load_cmd{1});
% 
% % Calculate weighted average of precisions
% avg_ac_mat = WAvg(ac_mat,instance_nums(1,:));
% avg_map_mat = WAvg(map_mat,instance_nums(1,:));
% avg_prec_mat = WAvg(prec_mat,instance_nums(1,:));
% avg_rec_mat = WAvg(rec_mat,instance_nums(1,:));
% avg_fs_mat = WAvg(fs_mat,instance_nums(1,:));
% 
% % Save data to a xlsx file
% for j = 1:size(tab_name_cell,2)
%     sz1 = eval(strcat('size(',tab_name_cell{j},')'));
%     eval(strcat('xlswrite(','''',xlsx_name,'''',',',tab_name_cell{j},',',num2str(j),',','''',alphbet_cell{1},num2str(1),':',alphbet_cell{sz1(2)},num2str(sz1(1)),'''',')'));
% end

function ret = mat2xlsx(data_loc, result_name, tab_name_cell)
    alphbet_cell = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
    
    mat_name = strcat(data_loc,result_name,'.mat');
    xlsx_name = strcat(data_loc,result_name,'.xlsx');
    
    load_cmd = strcat('load',{' '},mat_name);
    eval(load_cmd{1});
    
    for j = 1:size(tab_name_cell,2)
        sz1 = eval(strcat('size(',tab_name_cell{j},')'));
        eval(strcat('xlswrite(','''',xlsx_name,'''',',',tab_name_cell{j},',',num2str(j),',','''',alphbet_cell{1},num2str(1),':',alphbet_cell{sz1(2)},num2str(sz1(1)),'''',')'));
    end
    
    ret = 0;
end