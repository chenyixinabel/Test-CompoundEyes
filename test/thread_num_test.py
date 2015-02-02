import os, sys, math

def call_Hist_Nest_func(program_path, res_path, res_name, train_folder, train_gt_file, test_folder, test_gt_file, comp, fig_list, loop):
    clean_cmd = "rm -rf ../Label_files/ ../src/Nest/nest_*.conf"
    call_func_cmd = "./Hist_Nest_parallel_thd_num "+train_folder+ " "+train_gt_file+" "+test_folder+" "+test_gt_file+" " \
        +str(comp)+" "+str(fig_list[0])+" "+str(fig_list[1])+" "+str(fig_list[2])+" "+str(fig_list[3])+" "+str(fig_list[4]) \
        +" "+str(fig_list[5])+" "+str(fig_list[6])+" "+str(loop)+" " \
        ">> "+ res_name 
    mv_cmd = "mv " + res_name + " " + program_path + "/" + res_path

#     print cd_cmd
#     print clean_cmd
#     print call_func_cmd
#     print mv_cmd
    os.chdir(program_path)
    os.popen(clean_cmd)
    os.popen(call_func_cmd)
    os.popen(mv_cmd)

train_folder = sys.argv[2] + "/Test_v" + sys.argv[3] + "/" + sys.argv[3] + "_train/"
train_gt_file = sys.argv[2] + "/Test_v" + sys.argv[3] + "/groundtruth/GT_new_" + sys.argv[3] + "_train.txt"
test_folder = sys.argv[2] + "/Test_v" + sys.argv[3] + "/" + sys.argv[3] + "_test/"
test_gt_file = sys.argv[2] + "/Test_v" + sys.argv[3] + "/groundtruth/GT_new_" + sys.argv[3] + "_test.txt"
program_path = sys.argv[1]
res_path = sys.argv[4]
factor_list = [3, 34, 1, 7, 1, 7, 41]
factor_sum = sum(factor_list)

mk_cmd = "mkdir " + program_path + "/" + res_path
chmod_cmd = "chmod -R 777 " + program_path + "/" + res_path

# print mk_cmd
# print chmod_cmd

os.popen(mk_cmd)
os.popen(chmod_cmd)

for i in range(1, 8):
    res_name = "results_comp_" + str(i) + ".txt"
    fig_list = [4, 20, 1, 4, 1, 4, 25]
    call_Hist_Nest_func(program_path, res_path, res_name, train_folder, train_gt_file, test_folder, test_gt_file, i, fig_list, 3)
    
for i in range(1, 16):
    res_name = "results_eq_" + str(i) + ".txt"
    fig_list = [i, i, i, i, i, i, i]
    call_Hist_Nest_func(program_path, res_path, res_name, train_folder, train_gt_file, test_folder, test_gt_file, 7, fig_list, 3)
    
for i in range(10, 160, 10):
    res_name = "results_opt_" + str(i) + ".txt"
    fig_list = [int(math.ceil(i*fac/float(factor_sum))) for fac in factor_list]
    call_Hist_Nest_func(program_path, res_path, res_name, train_folder, train_gt_file, test_folder, test_gt_file, 7, fig_list, 3)
