import sys
import math

sprite_name = sys.argv[1]

with open(f"{sprite_name}.bmp","rb") as im:
    header = im.read(14)
    infoheader = im.read(40)
    offset = int.from_bytes(header[-4:],byteorder='little')
    width = int.from_bytes(infoheader[4:8],byteorder='little')
    height = int.from_bytes(infoheader[8:12],byteorder='little')
    planes = int.from_bytes(infoheader[12:14],byteorder='little')
    bpp = int.from_bytes(infoheader[14:16],byteorder='little')
    numcolors = int.from_bytes(infoheader[30:34],byteorder='little')
    # print("offset:",offset)
    # print(width,height,planes,bpp,numcolors)
    ## read in offset, minus bytes we've already read = (14+40)
    colortable = im.read(offset - (54))
    
    rows = [[] for i in range(height)]

    for y in range(height):
        for x in range(width):
            pixel = im.read(bpp//8)
            b,g,r,a = pixel[:]
            # print(r,g,b,a)
            r = int(math.sqrt(r) // 2)
            g = int(math.sqrt(g) // 2)
            b = int(math.sqrt(b) // 4)
            bval = f"{r:03b}{g:03b}{b:02b}" 
            # print(f"{int(bval,base=2):02x}")
            rows[-y].append(bval)
rows = "\n".join(["\n".join(row) for row in rows])
with open(f"{sprite_name}.mem","w") as mem:
    mem.writelines([f"{width:08b}\t//sprite width\n",f"{height:08b}\t//sprite height\n"])
    mem.write("//pixel data:\n")
    mem.writelines(rows)

# generate parameter
print(f"parameter {sprite_name.upper()}_IMG_SIZE = {width*height};")
print(f"parameter {sprite_name.upper()}_IMG_WIDTH = {width};")
print(f"parameter {sprite_name.upper()}_IMG_HEIGHT = {height};")