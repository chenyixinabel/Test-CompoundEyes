function [ ac_mat, map_mat, comb_times, instance_nums ] = test_combine( detector_num, data_loc )
    category_num = 24;
    ac_mat = zeros(detector_num+1, category_num);
    map_mat = zeros(detector_num+1, category_num);
    instance_nums = zeros(2,category_num);
    comb_times = zeros(1,category_num);
    
    for j = 1:category_num
        postp_times = zeros(detector_num+1,1);
        prep_times = zeros(detector_num,3);
        [ac_mat(:,j),map_mat(:,j),~,~,~,postp_times,instance_nums(:,j),prep_times] = bks(data_loc, j);
        comb_times(j) = postp_times(end);
    end
end

