import os, sys, math, random
import argparse, pickle

def setup_folders(dataset_folder_path, frame_folder_path, folder_count, dataset_ratio, train_set_ratio, vector_dir_path=None):
    create_outer_folder_cmd = "mkdir " + dataset_folder_path + "/Test_v" + str(folder_count)
    outer_folder_chmod_cmd = "chmod -R 777 " + dataset_folder_path + "/Test_v" + str(folder_count)
    create_inner_folder_cmd = create_outer_folder_cmd + "/groundtruth"
    inner_folder_chmod_cmd = "chmod 777 " + dataset_folder_path + "/Test_v" + str(folder_count) + "/groundtruth"
    copy_frame_folder_cmd = "cp -r " + frame_folder_path + "/vid_" + str(folder_count) + "_frames " + dataset_folder_path + "/Test_v" + str(folder_count)
    frame_folder_chmod_cmd = "chmod -R 777 " + dataset_folder_path + "/Test_v" + str(folder_count) + "/vid_" + str(folder_count) + "_frames"
    
    os.system(create_outer_folder_cmd)
    os.system(outer_folder_chmod_cmd)
    os.system(create_inner_folder_cmd)
    os.system(inner_folder_chmod_cmd)
    os.system(copy_frame_folder_cmd)
    os.system(frame_folder_chmod_cmd)
    
    videos_path = dataset_folder_path + "/Test_v" + str(folder_count) + "/vid_" + str(folder_count) + "_frames"
    video_name_list = dataset_folder_path + "/Test_v" + str(folder_count) + "/video_names"
    output_folder_path = dataset_folder_path + "/Test_v" + str(folder_count) + "/groundtruth"
    groundtruth_files = dataset_folder_path + "/Ground"
    video_list_all = dataset_folder_path + "/Video_List_simple.txt"
    seed_file = dataset_folder_path + "/Seed.txt"
    
    prepare_groundtruth(videos_path, groundtruth_files, video_name_list, video_list_all, seed_file, train_set_ratio, output_folder_path, folder_count, dataset_ratio, vector_dir_path)
    
    groundtruth_folder = output_folder_path + "/"
    input_vid_folder = dataset_folder_path + "/Test_v" + str(folder_count) + "/vid_" + str(folder_count) + "_frames/"
    output_vid_folder = dataset_folder_path + "/Test_v" + str(folder_count) + "/"
    
    prepare_video_sets(groundtruth_folder, input_vid_folder, output_vid_folder, folder_count);

    return
    
def prepare_groundtruth(videos_path, groundtruth_files, video_name_list, video_list_all, seed_file, train_set_ratio, output_folder_path, folder_count, dataset_ratio, vector_dir_path):
    path = os.path.dirname(videos_path)
    
    if os.path.exists(path):
        mkdir_cmd = "./partial_video_names_generator.sh " + videos_path + "/ " + path + "/video_names/ " + str(folder_count)
        os.system(mkdir_cmd)
        
    video_name_fd = open(video_name_list + "/VN" + str(folder_count) + ".txt", "r")
    source = [line[:-1] for line in video_name_fd]
    video_name_fd.close()
    
    groundtruth_file = groundtruth_files + '/GT_' + str(folder_count) + '.rst'
    groundTruth, _ = GT(groundtruth_file, video_list_all, seed_file, folder_count, source)
    
    if vector_dir_path == None:
        video_name_size = len(groundTruth)
        if dataset_ratio == 1:
            train_set_size = int(math.floor(video_name_size*train_set_ratio))
            train_set_idx = sorted(random.sample(range(video_name_size), train_set_size))
            test_set_idx = sorted(list(set(range(video_name_size)) - set(train_set_idx)))
        else:
            dataset_size = int(math.floor(video_name_size*dataset_ratio))
            train_set_size = int(math.floor(dataset_size*train_set_ratio))
            dataset_idx = random.sample(range(video_name_size), dataset_size)
            train_set_idx = sorted(dataset_idx[0:train_set_size])
            test_set_idx = sorted(dataset_idx[train_set_size:dataset_size])
        train_set = [groundTruth[i] for i in train_set_idx]
        test_set = [groundTruth[i] for i in test_set_idx]
    else:
        trn_vnames, test_vnames, _ = vname_reader(vector_dir_path, folder_count)
        gt_pos_dict = {}
        train_set = []
        test_set = []
        for pos, item in enumerate(groundTruth):
            gt_pos_dict[item[2]] = pos
        trn_vnames = sorted(trn_vnames, key=lambda x:int(x.split('_')[1]))
        test_vnames = sorted(test_vnames, key=lambda x:int(x.split('_')[1]))
        for name in trn_vnames:
            pos = gt_pos_dict[name]
            train_set.append(groundTruth[pos])
        for name in test_vnames:
            pos = gt_pos_dict[name]
            test_set.append(groundTruth[pos])
            
    train_set_output_path = output_folder_path + "/GT_new_" + str(folder_count) + "_train.txt"
    test_set_output_path = output_folder_path + "/GT_new_" + str(folder_count) + "_test.txt"
    with open(train_set_output_path, "w") as train_set_output_fd:
        for item in train_set:
            train_set_output_fd.write("%d %s %s\n" % (int(item[0]), item[1], item[2]))
    with open(test_set_output_path, "w") as test_set_output_fd:
        for item in test_set:
            test_set_output_fd.write("%d %s %s\n" % (int(item[0]), item[1], item[2]))

    return
    
def prepare_video_sets(groundtruth_folder, input_vid_folder, output_vid_folder, folder_count):
    train_gt_file_name = groundtruth_folder + "GT_new_" + str(folder_count) + "_train.txt"
    test_gt_file_name = groundtruth_folder + "GT_new_" + str(folder_count) + "_test.txt"
    
    with open(train_gt_file_name, "r") as train_gt_file_fd:
        train_gt_list = [line.strip().split(" ") for line in train_gt_file_fd]
        train_video_name_list = [train_gt_list[i][2] for i in range(len(train_gt_list))]
    with open(test_gt_file_name, "r") as test_gt_file_fd:
        test_gt_list = [line.strip().split(" ") for line in test_gt_file_fd]
        test_video_name_list = [test_gt_list[i][2] for i in range(len(test_gt_list))]
                
    train_video_output_path = output_vid_folder + str(folder_count) + "_train"
    mk_train_folder_cmd = "mkdir " + train_video_output_path
    chmod_train_folder_cmd = "chmod 777 " + train_video_output_path
    os.system(mk_train_folder_cmd)
    os.system(chmod_train_folder_cmd)
    
    test_video_output_path = output_vid_folder + str(folder_count) + "_test"
    mk_test_folder_cmd = "mkdir " + test_video_output_path
    chmod_test_folder_cmd = "chmod 777 " + test_video_output_path
    os.system(mk_test_folder_cmd)
    os.system(chmod_test_folder_cmd)
        
    for video_folder in train_video_name_list:
        video_folder_path = input_vid_folder + video_folder
        move_video_folder_cmd = "mv " + video_folder_path + " " + train_video_output_path
        os.system(move_video_folder_cmd)
        
    for video_folder in test_video_name_list:
        video_folder_path = input_vid_folder + video_folder
        move_video_folder_cmd = "mv " + video_folder_path + " " + test_video_output_path
        os.system(move_video_folder_cmd)

    return
        
    
def GT(gt_file_name, vid_list_file_name, seed_file, gt_file_count, video_source):
    gt_file_fd = open(gt_file_name)
    vid_list_fd = open(vid_list_file_name)
    seed_file_fd = open(seed_file)
    
    gt_list = [line.strip().split("\t") for line in gt_file_fd]
    vn_list = [line.strip().split(",") for line in vid_list_fd]
    seed_list = [line.strip().split("\t") for line in seed_file_fd]
    
    gt_id_list = [gt_list[i][0] for i in range(len(gt_list))]
    gt_fact_list = [gt_list[i][1] for i in range(len(gt_list))]
    video_id_list = [vn_list[i][0] for i in range(len(vn_list))]
    video_name_list = [vn_list[i][1] for i in range(len(vn_list))]
    seed_num = seed_list[gt_file_count-1][1]
    
    groundTruth = []
    vid_source_idx = 0
    for i in gt_id_list:
        i = int(i)-1
        if video_id_list[i] == seed_num:
            seed_name = video_name_list[i].split(".")[0]
        video_name = video_name_list[i].split(".")[0]
        if video_name == video_source[vid_source_idx]:
            gt_id = video_id_list[i]
            gt_idx = gt_id_list.index(video_id_list[i])
            gt_fact = gt_fact_list[gt_idx]
            if vid_source_idx < len(video_source)-1:
                vid_source_idx = vid_source_idx + 1
            groundTruth.append([gt_id, gt_fact, video_name])
    
    gt_file_fd.close()
    vid_list_fd.close()
    seed_file_fd.close()
    
    return groundTruth, seed_name

def input_path_form_check(path):
    if path.startswith("~/"):
        path = os.path.expanduser(path)
    ret_path = os.path.abspath(path)
    return ret_path

def vname_reader(dir_path, folder_count):
    vname_dict = {}
    seed_dict_path = dir_path + '/seed_vnamevgg16_dict'
    
    trn_vname_vec_dict_path = dir_path + '/train-vgg16/train_vname_vgg16_dict_' + str(folder_count)
    test_vname_vec_dict_path = dir_path + '/test-vgg16/test_vname_vgg16_dict_' + str(folder_count)
    trn_vname_vec_dict = pickle.load(open(trn_vname_vec_dict_path, 'r'))
    test_vname_vec_dict = pickle.load(open(test_vname_vec_dict_path, 'r'))
    trn_vnames = trn_vname_vec_dict.keys()
    test_vnames = test_vname_vec_dict.keys()
        
    seed_dict = pickle.load(open(seed_dict_path, 'r'))
    seeds = sorted(seed_dict.keys(), key=lambda x:int(x.split('_')[0]))
    
    return trn_vnames, test_vnames, seeds

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    # e.g., /home/yixin/dataset/CC_WEB_VIDEO #
    parser.add_argument('dataset_folder_path', help='The path to the location of output directory.')
    # e.g., /home/yixin/dataset/CC_WEB_VIDEO/vid_frames_all #
    parser.add_argument('frames_folder_path', help='The path to the directory of all video frames.')
    # e.g., 0.1 #
    parser.add_argument('dataset_ratio', type=float, help='The ratio of the selected dataset to the original dataset.')
    # e.g., 0.5 #
    parser.add_argument('train_set_ratio', type=float, help='The ratio of the training set to the selected dataset.')
    # e.g., /home/yixin/dataset/CC_WEB_VIDEO/feature_vectors/vgg16-vec #
    parser.add_argument('-v', help='The path to the directory of the extracted feature vectors.')
    args = parser.parse_args()

    dataset_folder_path = input_path_form_check(args.dataset_folder_path)
    frames_folder_path = input_path_form_check(args.frames_folder_path)
    dataset_ratio = args.dataset_ratio
    train_set_ratio = args.train_set_ratio

    query_num = 24
     
    for i in range(query_num):
        if args.v == None:
            setup_folders(dataset_folder_path, frames_folder_path, i+1, dataset_ratio, train_set_ratio)
        else:
            setup_folders(dataset_folder_path, frames_folder_path, i+1, dataset_ratio, train_set_ratio, input_path_form_check(args.v))
         
    wrapper_folder = dataset_folder_path + "/Test_s_" + str(dataset_ratio) + "_p_" + str(train_set_ratio) + "/"
    mk_wrapper_folder_cmd = "mkdir " + wrapper_folder
    chmod_wrapper_folder_cmd = "chmod -R 777 " + wrapper_folder
    os.system(mk_wrapper_folder_cmd)
    os.system(chmod_wrapper_folder_cmd)
     
    for i in range(query_num):
        move_folder_cmd = "mv " + dataset_folder_path + "/Test_v" + str(i+1) + "/ " + wrapper_folder
        os.system(move_folder_cmd)
