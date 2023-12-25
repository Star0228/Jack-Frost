from PIL import Image
import os

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
                r, g, b = pix[x, y][:3]
                coe_file.write('%01x%01x%01x,\n' % (r >> 4, g >> 4, b >> 4))
        coe_file.seek(coe_file.tell() - 2, 0) # remove last comma
        coe_file.write(';')
# bmp_to_coe('D:\\CS\\Logic-studying\\Jack Frost\\素材导出\\shapes\\2199.bmp')