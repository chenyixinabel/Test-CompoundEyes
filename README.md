# Test-CompoundEyes

The goal of this project is to evaluate the performance of CompoundEyes on the CC\_WEB\_VIDEO dataset. Sources files are grouped into four directories, they are as follows:

## Description of the four directories
1. bks\_alg: Implement the BKS algorithm to combine the intermediary results stored in /path/to/result/files/Test\_v(the group number: 1-24)/inter\_save/Label\_files/ to form the final results, and to evaluate the average accuracy and mean average precision of these final results.
2. input_setup: Randomly select a portion of videos, which have already been decomposed, as the training video set. The rest is regarded as the testing video set. Corresponding groundtruth items should also be split in the same way of splitting the videos.
3. test: Experiments on different branches of CompoundEyes, results are recorded.
4. vid\_decomp: Decompose videos into frames, each video corresponds to a set of frames.

## How to use
To conduct experiments on CompoundEyes, you should follow these steps:
1. Decompose videos into frames.
2. Divide videos into a training set and a testing set.
3. Run the program of CompoundEyes, calculate the detection results, and evaluate performance.
4. Conduct other experiments if necessary, including evaluating the effect of different combinations of feature extractors, the effect of r and k, and the performance when the number of threads changes.

## Decompose videos into frames
1. Run decomp.sh to extract key-frames from videos, e.g., ./decomp.sh /home/username/videos/ /home/username/vid\_frames\_all/ jpeg.
2. Run copy\_missing\_videos.sh to find out which video has been failed in the previous extraction process, then copy these videos into a directory. For example, ./copy\_missing\_videos.sh /home/username/vid\_frames\_all/ /home/username/videos/ /home/username/missing/.
3. Delete the empty video directories in /home/username/vid\_frames\_all.
4. Run decomp.sh to extract key-frames from videos failed in the last round of extraction, e.g., ./decomp.sh /home/username/missing/ /home/username/vid\_frames\_all/ jpeg. Step 2 to 4 could last for several rounds until all the videos have at least one key-frame extracted.
5. The optical flow feature extractor requires at least two frames to calculate a flow, thus we need to ensure that each video has at least two frames extracted. Run count\_file\_num.sh to find out which video has only one key-frame extracted and copy these video into a directory. For example, ./count\_file\_num.sh /home/username/vid\_frames\_all/ 1 /home/username/redecomp/ /home/username/videos/.
6. Delete the video directories in /home/username/vid\_frames\_all which have only one key-frame extracted.
7. Run new\_decomp.sh to extract frames from videos which have only one key-frame extracted. This script extracts frames according to frame rate. It should run as, ./new\_decomp.sh /home/username/redecomp/ /home/username/vid\_frames\_all/ jpeg. Step 5 to 7 should also be iterated for several rounds until all the videos have at least two frames extracted.
8. Group the video directories in /home/username/vid\_frames\_all into 24 groups, e.g., vid\_1\_frames, vid\_2\_frames, etc.

## Divide videos into a training set and a testing set
1. Be sure that partial\_video\_names\_generator.sh is in the same directory with Input\_setup.py.
2. Run Input\_setup.py to separate decomposed videos into a training set and a testing set, e.g., python Input\_setup.py /home/username/dataset(where you are going to store the generated dataset of videos) /home/username/vid\_frames\_all 0.1(the quantity of videos selected for evaluation) 0.5(the portion of the training set in the selected videos)
3. When step 2 finishes, there will generate a dataset in /home/username/dataset, Test\_s\_0.1\_p\_0.5, if the arguments to Inputy\_setup.py are the same as the example in step 2.
4. For the feature vectors extracted in CC\_WEB\_VIDEO/feature_vectors, we can rebuild the dataset by adding the '-v' option, which is followed by the location where the vector stored, such as /home/yixin/dataset/CC\_WEB\_VIDEO/feature\_vectors/vgg16-vec.

## How to run the program of CompoundEyes

Generally, we do not directly divide videos into a training set and a testing set by ourselves. The program Input\_setup.py is called by other programs for the preparation of dataset. In the directory test, there are plenty of scripts for running CompoundEyes on a variety of datasets with different amount of videos and portion of training set.

Suppose the programs of CompoundEyes are in /home/username/workspace/, datasets are in /home/username/dataset, and Input\_setup.py is in /home/username/workspace/Vid\_Input\_Setup, the examples of running CompoundEyes are as follows:

1. Running the serial version of CompoundEyes: ./batch\_classification\_new.sh /home/username/workspace/Hist\_Nest\_new/Debug/ /home/username/dataset/Test\_s\_0.1\_p\_0.5/ (In this case, we need to construct the dataset used in the experiment first, via Input\_setup.py).
2. Running the paralle version of CompoundEyes: there are two ways to run this version, which will be explained in step 3, 4, and 5.
3. The first one is similar to the example above, constructing dataset first, then running the program by ./batch\_classification\_parallel.sh /home/username/workspace/Hist\_Nest\_new/Debug/ /home/username/dataset/Test\_s\_0.1\_p\_0.5/.
4. The second one contains two bundles of experiments. In the first bundle, all the videos are included in the experiments, and the portion of the training set varies from 90% to 10%. In the second bundle, the portion of the training set stays at 50%, and the amount of videos included varies from 90% to 10%.
5. To start these experiments, we only need to enter ./expe\_instances.sh /home/usrname/workspace/Vid\_Input\_Setup /home/username (this is where the directory vid\_frames\_all is) /home/username/workspace/Test-CompoundEyes/test (this is where the batch\_classification\_parallel.sh is) /home/username/workspace/Hist\_Nest\_parallel/Debug.
6. Notice that before running these experiments, we need to make sure that all the intermediary result files, located in /home/username/workspace/Hist\_Nest\_(new or parallel)/Label files (this location is configured in a source file of CompoundEyes), /home/username/workspace/Hist\_Nest\_(new or parallel)/Debug/results.txt have been deleted, so are the configure files for Nest, located in /home/username/workspace/Hist\_Nest\_(new or parallel)/src/Nest, except nest.conf.

## How to calculate the detection results, and evaluate performance

Having finished the experiments of CompoundEyes mentioned above, results are scattered in directories as /home/username/dataset/your-dataset/Test\_v1(from 1 to 24)/inter\_save. Suppose our dataset is Test\_s\_1.0\_p\_0.5, to obtain the final results and evaluate the performance, in terms of accuracy and efficiency, we should follow these steps:

1. In bks\_alg/bks\_combine.m, configure save\_loc, detector\_num, category\_num, data\_loc, and save\_file\_name accordingly. For instance, save\_loc = '/home/username/test/results/', detector\_num = 7, category\_num = 24, data\_loc = '/home/username/dataset/Test\_s\_1.0\_p\_0.5/', save\_file\_name = 'results\_s\_1d0\_p\_0d5.mat'.
2. Run bks\_combine.m in Matlab.
3. Run test/mat2xlsx.m to facilitate charting on the evaluation results. This could be done by calling mat2xlsx('/home/username/test/results', 'results\_s\_1d0\_p\_0d5', {'avg\_ac\_mat', 'avg\_map\_mat', 'all\_time', 'avg\_\all\_time', 'avg\_pre\_proc\_time', 'avg\_proc\_time'}) in Matlab.

## The Effect of different combinations of feature extractors
Due to the flexibility of CompoundEyes, we could theoretically employ an arbitrary number of feature extractors. At this phase, seven feature extractors have been implemented. We are curious about the performance of different combinations of them, in terms of accuracy and detection speed.

With the results produced by previous experiments, we could evaluate the accuracy of all the possible combinations as follows:
1. Copy the results produced by CompoundEyes in the last section to a temporary location, for example, /home/username/tmp.
2. Change the configurations in combination\_test.m, all\_data\_path = '/home/username/tmp/Test\_s\_1.0\_p\_0.5', all\_save\_path = '/home/username/tmp/Test\_combine/', save\_file\_name = 'combine\_s\_1d0\_p\_0d5.mat', save\_loc = '/home/username/test/combine\_results/'. Make sure that these directories exist.
3. Run combination\_test.m in Matlab.
4. Change the configurations in combination\_test\_xlsx.m, data\_loc = '/home/username/test/combine\_results/', result\_name = 'combine\_s\_1d0\_p\_0d5'.
5. Run combination\_test\_xlsx.m in Matlab.

After the evaluation of all the possible combinations, we are aware of the best combinations given the number of feature extractors. Next, we want to the detection speed of these combinations. Suppose all the projects of CompoundEyes with different combinations of feature extractors have been built and located in /home/username/workspace/, and their names are in the form of Hist\_Nest\_parallel\_1 (from 1 to 6, indicates the number of feature extractors included). This could be done by the following steps:
1. Run ./batch\_classification\_parallel\_num.sh /home/username/workspace/ /home/username/dataset/Test\_s\_1.0\_p\_0.5/ /home/username/test/combine\_results
2. Change the configurations in bks\_combine.m, save\_loc = '/home/username/test/combine\_results/', detector\_num = 1 (from 1 to 6), data\_loc = '/home/username/test/combine\_results/best\_comb\_test/1\_Test/' (from 1\_Test to 6\_Test).
3. Run bks\_combine.m in Matlab.

## The Effect of r and k

## The performance variation when the number of threads changes
