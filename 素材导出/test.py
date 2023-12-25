import os
from PIL import Image

def bmp_to_coe(input_file):
    # 获取输入文件的基础名（无扩展名）
    base_name = os.path.splitext(input_file)[0]
    # 拼接出输出文件名
    output_file = base_name + ".coe"
    im = Image.open(input_file)
    pix = im.load()
    with open(output_file, 'w') as coe_file:
        coe_file.write('memory_initialization_radix=16;\n')
        coe_file.write('memory_initialization_vector=\n')
        for y in range(im.size[1]):
            for x in range(im.size[0]):
                r ,g,b= pix[x, y]
                coe_file.write('%01x%01x%01x,\n' % (r% 4, g >> 4, b >> 4))
        coe_file.seek(coe_file.tell() - 2, 0) # remove last comma
        coe_file.write(';')

def bmp_to_coe24(input_file):
    # 获取输入文件的基础名（无扩展名）
    base_name = os.path.splitext(input_file)[0]
    # 拼接出输出文件名
    output_file = base_name + ".coe"
    im = Image.open(input_file)
    pix = im.load()
    with open(output_file, 'w') as coe_file:
        coe_file.write('memory_initialization_radix=16;\n')
        coe_file.write('memory_initialization_vector=\n')
        for y in range(im.size[1]):
            for x in range(im.size[0]):
                r,g,b= pix[x, y]
                coe_file.write('%02x%02x%02x,\n' % (r, g , b))
        coe_file.seek(coe_file.tell() - 2, 0) # remove last comma
        coe_file.write(';')

def rename_files_in_directory(directory_path, prefix_str):
    for file_name in os.listdir(directory_path):
        if file_name.endswith('.coe'):
            new_name = prefix_str + file_name
            old_file_path = os.path.join(directory_path, file_name)
            new_file_path = os.path.join(directory_path, new_name)
            os.rename(old_file_path, new_file_path)



folder_path = 'D:\\CS\\Logic-studying\\Jack-Frost\\素材导出\\sprites\\粘液怪物向左走动'
for filename in os.listdir(folder_path):
    if filename.endswith('.bmp'):
        full_path = os.path.join(folder_path, filename)
        bmp_to_coe(full_path)
        
# 使用方法: 指定文件夹路径和前缀字符串
rename_files_in_directory("D:\\CS\\Logic-studying\\Jack-Frost\\素材导出\\sprites\\粘液怪物向左走动", "slim_l-walk_")
