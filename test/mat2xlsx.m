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
