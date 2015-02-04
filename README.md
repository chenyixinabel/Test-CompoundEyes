# Test-CompoundEyes

The goal of this project is to evaluate the performance of CompoundEyes on the CC\_WEB\_VIDEO dataset. Sources files are grouped into four directories, they are as follows:

## Description of the four directories
1. bks\_alg: Implement the BKS algorithm to combine the intermediary results stored in /path/to/result/files/Test\_v(the group number: 1-24)/inter\_save/Label\_files/ to form the final results, and to evaluate the average accuracy and mean average precision of these final results.
2. input_setup: Randomly select a portion of videos, which have already been decomposed, as the training video set. The rest is regarded as the testing video set. Corresponding groundtruth items should also be split in the same way of splitting the videos.
3. test: Experiments on different branches of CompoundEyes, results are recorded.
4. vid\_decomp: Decompose videos into frames, each video corresponds to a set of frames.

## How to use
To test CompoundEyes, you should follow these steps:
