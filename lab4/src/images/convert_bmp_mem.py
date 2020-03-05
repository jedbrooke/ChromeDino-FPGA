import sys
import math
from itertools import chain

known_dists = {}
def getDist(c1,c2):
    key = c1+c2
    if key in known_dists:
        return known_dists[key]

    vals1 = c1[:-3],c1[2:5],c1[0:2]
    vals1 = [int(v,base=2) for v in vals1]

    vals2 = c2[:-3],c2[2:5],c2[0:2]
    vals2 = [int(v,base=2) for v in vals2]
    diffs = [(v2 - v1)**2 for v1,v2 in zip(vals1,vals2)]
    dist = math.sqrt(sum(diffs))
    known_dists[key] = dist
    return dist


sprite_name = sys.argv[1]

BG_COLOR = '11111111'
NUM_COLORS = 4

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
    colors = {}
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
            if not bval in colors:
                colors[bval] = 1
            else:
                colors[bval] += 1
            rows[-y].append(bval)
    

colors = [(k,v) for k,v in colors.items() if k != BG_COLOR]
colors.sort(reverse=True,key=lambda c1: c1[1])
colors = colors[:NUM_COLORS] + [(BG_COLOR,0)]
colors_lut = dict(zip([c[0] for c in colors],[f"{i:02b}1" for i in range(NUM_COLORS)]))
colors_lut[BG_COLOR] = '000'


#convert colors to mapping
for r in range(len(rows)):
    for c in range(len(rows[r])):
        if not rows[r][c] in colors:
            dists = [getDist(c1[0],rows[r][c]) for c1 in colors]
            rows[r][c] = colors[dists.index(min(dists))][0]
        rows[r][c] = colors_lut[rows[r][c]]
           
rows = "\n".join([" ".join(row) for row in reversed(rows)])
color_table = "\n".join([c[0] for c in colors[:NUM_COLORS]])

with open(f"{sprite_name}_meta.mem","w") as mem:
    mem.writelines([f"{width:08b}\t//sprite width\n",f"{height:08b}\t//sprite height\n"])
    mem.write("//color data:\n")
    mem.write(color_table)

with open(f"{sprite_name}.mem","w") as mem:
    mem.write("//pixel data:\n")
    mem.writelines(rows)

# generate parameter
print(f"parameter {sprite_name.upper()}_IMG_SIZE = {width*height};")
print(f"parameter {sprite_name.upper()}_IMG_WIDTH = {width};")
print(f"parameter {sprite_name.upper()}_IMG_HEIGHT = {height};")