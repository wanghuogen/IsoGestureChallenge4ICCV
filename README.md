# IsoGestureChallenge for ICCV2017
There are the structions for using the codes.

Before using our codes, you'd better rebuild the liblinear.(Run "make" in "liblinear/matlab")

Place the Original DATASET in the folder "DATA"
 
#1.Training Part preprocessing

step1. Generate the DepthDI

run code "main4train4Depth4Original.m" 

run code "main4train4Depth4Hand.m" 

step2. Generate the RgbDI

run code "main4train4Rgb4Original.m" 

run code "main4train4Rgb4Hand.m" 

step3. Extract the RGB frame for Tensorflow

run code "train_RGB.m" 

step4. Extract the depth frame for Tensorflow

run code "train_depth.m" 

#2.Validation Part preprocessing

step1. Generate the DepthDI

run code "main4valid4Depth4Original.m" 

run code "main4valid4Depth4Hand.m" 

step2. Generate the RgbDI

run code "main4valid4Rgb4Original.m" 

run code "main4valid4Rgb4Hand.m" 

step3. Extract the RGB frame for Tensorflow

run code "valid_RGB.m" 

step4. Extract the depth frame for Tensorflow

run code "valid_depth.m" 

#3. Test Part preprocessing

step1. Generate the DepthDI

run code "main4test4Depth4Original.m" 

run code "main4test4Depth4Hand.m" 

step2. Generate the RgbDI

run code "main4test4RGB4Original.m" 

run code "main4test4Rgb4Hand.m" 

step3. Extract the RGB frame for Tensorflow

run code "test_RGB.m" 

step4. Extract the depth frame for Tensorflow

run code "test_depth.m" 

#4.Steps for training using caffe

step1. Install Caffe following the original README of Caffe.


step2. step into the every folders in "caffe4IsoGD", and train the models.

 Run "sh create_imagenet_vgg.sh"
 Run "sh make_imagenet_mean_vgg.sh"
 Run "python convert_vgg.py"
 Run "sh train_caffenet_vgg.sh"

You'd better training depth-part first, and use the model of depth as the pred-trained model to train RGB part.

#5.Steps for training using Tensorflow

step1. Install Tensorflow-0.11 and Tensorlayer

step2. Modify the class RNNLayer in tensorlayer/layer.py according to the tensorlayer-rnnlayer.py in the folder "LSTM"

step3.Copy the folder "image4tensorflow" into "LSTM" folder.

step4. train the network
       Run "training_depth_full.py"(about 60000 iterations)
       Run "training_depth_fullbody.py"(about 60000 iterations)
       Run "training_rgb_full.py" (about 60000 iterations)
       Run "training_rgb_fullbody.py"(about 60000 iterations)
step5. Fine-tuning the RGB neural network using the Rgb models as the pre-trained model, and  fine-tuning the depth neural network using the Rgb models as the pre-trained model.

#6.Generate the test_prediction.txt

step1.In LSTM, run "python test4depth.py", "test4depth_full.py","test4rgb.py","test4rgb_full.py"

step2. run the code "classifier4fusion12.py" in the folder. Please change caffe_root in the very beginning 

If you use our code,please cite our paper:
@InProceedings{Wang_2017_ICCV_Workshops, 
author = {Wang, Huogen and Wang, Pichao and Song, Zhanjie and Li, Wanqing}, 
title = {Large-Scale Multimodal Gesture Recognition Using Heterogeneous Networks}, 
booktitle = {The IEEE International Conference on Computer Vision (ICCV)}, 
month = {Oct}, year = {2017} }
@InProceedings{Wang_2017_ICCV_Workshops, 
author = {Wang, Huogen and Wang, Pichao and Song, Zhanjie and Li, Wanqing}, 
title = {Large-Scale Multimodal Gesture Segmentation and Recognition Based on Convolutional Neural Networks}, 
booktitle = {The IEEE International Conference on Computer Vision (ICCV)}, 
month = {Oct}, year = {2017} } 
