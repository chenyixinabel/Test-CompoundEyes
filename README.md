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
4. Conduct other experiments if necessary.

## Decompose videos into frames
1. Run decomp.sh to extract key-frames from videos, e.g., ./decomp.sh ~/username/videos/ ~/username/vid\_frames\_all/ jpeg.
2. Run copy\_missing\_videos.sh to find out which video has been failed in the previous extraction process, then copy these videos into a directory. For example, ./copy\_missing\_videos.sh ~/username/vid\_frames\_all/ ~/username/videos/ ~/username/missing/.
3. Delete the empty video directories in ~/username/vid\_frames\_all.
4. Run decomp.sh to extract key-frames from videos failed in the last round of extraction, e.g., ./decomp.sh ~/username/missing/ ~/username/vid\_frames\_all/ jpeg. Step 2 to 4 could last for several rounds until all the videos have at least one key-frame extracted.
5. The optical flow feature extractor requires at least two frames to calculate a flow, thus we need to ensure that each video has at least two frames extracted. Run count\_file\_num.sh to find out which video has only one key-frame extracted and copy these video into a directory. For example, ./count\_file\_num.sh ~/username/vid\_frames\_all/ 1 ~/username/redecomp/ ~/username/videos/.
6. Delete the video directories in ~/username/vid\_frames\_all which have only one key-frame extracted.
7. Run new\_decomp.sh to extract frames from videos which have only one key-frame extracted. This script extracts frames according to frame rate. It should run as, ./new\_decomp.sh ~/username/redecomp/ ~/username/vid\_frames\_all/ jpeg. Step 5 to 7 should also be iterated for several rounds until all the videos have at least two frames extracted.
8. Group the video directories in ~/username/vid\_frames\_all into 24 groups, e.g., vid\_1\_frames, vid\_2\_frames, etc.

## Divide videos into a training set and a testing set

## Run the program of CompoundEyes, calculate the detection results, and evaluate performance

## Conduct other experiments if necessary
