from os import listdir
import sys, re, xlwt

def res_file_reorder(res_file_path):
    thd_res_name_list = listdir(thd_res_path)
    tmp_list = [name.split('.')[0].split('_') for name in thd_res_name_list]
    tmp_list = sorted(tmp_list, key = lambda x: (x[1], int(x[-1])))
    thd_res_name_list = [x[0]+'_'+x[1]+'_'+x[2]+'.txt' for x in tmp_list]
    return thd_res_name_list

def get_num_list(res_file_name):
    nums = []
    for line in open(res_file_name):
        nums = nums + re.findall(r'is[:]*\s(\d+.\d+)', line)
    return nums

def get_all_num_list(thd_res_path):
    thd_res_name_list = res_file_reorder(thd_res_path)
    all_num_list = []
    for name in thd_res_name_list:
        fname = thd_res_path + '/' + name
        num_list = get_num_list(fname)
        all_num_list.append(num_list)
    return all_num_list

def write_xls(all_num_list, xls_path):
    book = xlwt.Workbook(encoding='utf-8')
    sheet1 = book.add_sheet("thread")
    for i in range(len(all_num_list)):
        sheet1.write(i, 0, all_num_list[i][0])
        sheet1.write(i, 1, all_num_list[i][1])
        sheet1.write(i, 2, all_num_list[i][2])
        sheet1.write(i, 3, all_num_list[i][3])
    book.save(xls_path)

#seq_res_path = sys.argv[1]
thd_res_path = sys.argv[1]
xls_path = sys.argv[2]

all_num_list = get_all_num_list(thd_res_path)
write_xls(all_num_list, xls_path)


    


