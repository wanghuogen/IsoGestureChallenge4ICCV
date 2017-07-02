import sys
sys.path.append('/home/huogen/git/caffe/python')
from caffe.proto import caffe_pb2
import caffe.io
from caffe.io import blobproto_to_array
import numpy as np

blob = caffe_pb2.BlobProto()
data = open("DepthFullbody_dir_mean_vgg.binaryproto", "rb").read()
blob.ParseFromString(data)
nparray = np.array(blobproto_to_array(blob))
f = file("DepthFullbody_dir_mean_vgg.npy","wb")
np.save(f,nparray[0])
f.close()
