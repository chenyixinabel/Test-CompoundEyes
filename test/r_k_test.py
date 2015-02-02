import os, sys

def call_Hist_Nest_func(program_path, dataset_path, offset_r, offset_k):
    result_path = program_path + "/Test_r_" + str(offset_r) + "_k_" + str(offset_k)
    mk_1_cmd = "mkdir " + result_path
    chmod_1_cmd = "chmod -R 777 " + result_path
#     print mk_1_cmd
#     print chmod_1_cmd
    os.system(mk_1_cmd)
    os.system(chmod_1_cmd)
    for i in range(1,25):
        train_folder = dataset_path+"/Test_v"+str(i)+"/"+str(i)+"_train/"
        train_gt_file = dataset_path+"/Test_v"+str(i)+"/groundtruth/GT_new_"+str(i)+"_train.txt"
        test_folder = dataset_path+"/Test_v"+str(i)+"/"+str(i)+"_test/"
        test_gt_file = dataset_path+"/Test_v"+str(i)+"/groundtruth/GT_new_"+str(i)+"_test.txt"
        
        cd_1_cmd = "cd " + program_path + "/Debug"
        mk_2_cmd = "mkdir " + result_path + "/Test_v" + str(i)
        chmod_2_cmd = "chmod -R 777 " + result_path + "/Test_v" + str(i)
        mk_3_cmd = "mkdir " + result_path + "/Test_v" + str(i) + "/inter_save"
        chmod_3_cmd = "chmod -R 777 " + result_path + "/Test_v" + str(i) + "/inter_save"
        clean_cmd = "rm -rf ../Label_files/ results.txt ../src/Nest/nest_*.conf"
        call_func_cmd = "./Hist_Nest_parallel_r_k "+train_folder+ " "+train_gt_file+" "+test_folder+" "+test_gt_file+" " \
                        +str(offset_r)+" "+str(offset_k)+" >> results.txt"
        cd_2_cmd = "cd .."
        cp_cmd = "cp -r Label_files/ Debug/results.txt " + result_path + "/Test_v" + str(i) + "/inter_save"
        
#         print mk_2_cmd
#         print chmod_2_cmd
#         print mk_3_cmd
#         print chmod_3_cmd
#         print cd_1_cmd
#         print clean_cmd
#         print call_func_cmd
#         print cd_2_cmd
#         print cp_cmd
        
        os.system(mk_2_cmd)
        os.system(chmod_2_cmd)
        os.system(mk_3_cmd)
        os.system(chmod_3_cmd)
        os.chdir(program_path + "/Debug")
        os.system(clean_cmd)
        os.system(call_func_cmd)
        os.chdir(program_path + "/Debug/..")
        os.system(cp_cmd)
        
program_path = sys.argv[1]
dataset_path = sys.argv[2]

for i in range(-3,8):
    offset_r = i*0.005
    offset_k = 0
    call_Hist_Nest_func(program_path, dataset_path, offset_r, offset_k)
    
for i in range(-2,18,2):
    offset_r = 0;
    offset_k = i
    call_Hist_Nest_func(program_path, dataset_path, offset_r, offset_k)