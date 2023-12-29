import os
import shutil

source = '../2023pics-raw'
fnames = os.listdir(source)

name_dict = {
    "20230723_115733.jpg": "kayak_umb.jpg",
    "20230724_125953.jpg": "kayak_pad.jpg",
    "20230826_150412.jpg": "catamaran.jpg",
    "G&M_1452.jpg": "gm_wedding.jpg",
    "G&M_1068.jpg": "gm_wedding_p.jpg",
    "G&M_0544.jpg": "gm_wedding_s.jpg",
    "IMG_20231205_213940106_HDR.jpg": "xmas_tree.jpg",
    "IMG_20231206_202529802_HDR.jpg": "cookies.jpg",
    "IMG_6851.jpg": "halloween_porch.jpg",
    "Image_20230107_180853_665.jpg": "ski_garnet.jpg",
    "PXL_20230107_164708115.jpg": "ski_pavlo.jpg",
    "PXL_20230114_170714224.jpg": "squirrel.jpg",
    "PXL_20230225_190532321.jpg": "ski_osceola.jpg",
    "PXL_20230318_213009312.jpg": "tree_roof.jpg",
    "PXL_20230324_013136396.jpg": "salamander.jpg",
    "PXL_20230330_000933789.jpg": "snow.jpg",
    "PXL_20230402_040617038.jpg": "tm_wedding.jpg",
    "PXL_20230402_212206979.jpg": "wheel.jpg",
    "PXL_20230402_220420961.jpg": "beach.jpg",
    "PXL_20230406_234925527.jpg": "oak.jpg",
    "PXL_20230406_235117313.jpg": "oak_pavlo.jpg",
    "PXL_20230601_223016161.mp4": "parade.mp4",
    "PXL_20230617_183040108.jpg": "rhubarb.jpg",
    "PXL_20230621_230949844.jpg": "kayak_swim.jpg",
    "PXL_20230628_142919215.MP.jpg": "garden.jpg",
    "PXL_20230630_214726070.jpg": "sacandaga.jpg",
    "PXL_20230708_234345533.MP.jpg": "yupa_pavlo.jpg",
    "PXL_20230709_000808908.jpg": "yupa_sarah.jpg",
    "PXL_20230806_191227887.jpg": "yupa_swim.jpg",
    "PXL_20230825_230327741.MP.jpg": "grill.jpg",
    "PXL_20230903_231902658.jpg": "yupa_legs.jpg",
    "PXL_20230904_202729042.jpg": "yupa_friends.jpg",
    "PXL_20230915_223856180.jpg": "yupa_sp.jpg",
    "PXL_20230916_202538770.jpg": "yupa_mast.jpg",
    "PXL_20231027_222703962.jpg": "halloween_bike.jpg",
    "PXL_20231028_192651375.jpg": "halloween_cider.jpg",
    "PXL_20231031_214355890.MP.jpg": "halloween_tree.jpg",
    "PXL_20231202_143118145.jpg": "house.jpg",
    "PXL_20231225_231200904.MP.jpg": "xmas_dinner.jpg",
    "received_1528277494630302.jpg": "tgives.jpg",
    "received_6488297191255077.jpg": "bb_wedding.jpg",
    "received_686040063186110.jpg": "tgives_canada.jpg",
    "received_697014265641493.jpg": "granny_yard2.jpg",
    "received_858752922153196.jpg": "granny_yard1.jpg",
    "received_916557616289376.jpg": "waterfall.jpg",
    "received_924388202165553.jpg": "yupa.jpg",
}

fnames.sort()
for fname in fnames:
    # print("\"" + fname + "\": ,")
    shutil.copy(os.path.join(source, fname), os.path.join('.', name_dict[fname]))
