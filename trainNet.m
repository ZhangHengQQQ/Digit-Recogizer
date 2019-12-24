clc
clear 
close all
%%导入数据
imageTrain = imageDatastore('trainSet',...
    'IncludeSubfolders',true,'LabelSource','foldernames');%采用文件夹名称作为数据标记
%%数据集图个数
countEachLabel(imageTrain)
numTrainFiles = 0.2;%每一个数字有22个样本，取17个样本作为训练数据
[imdsTrain,imdsValidation] = splitEachLabel(imageTrain,numTrainFiles,'randomized');
%%定义卷积神经网络的结构
layers = [
    %输入层
    imageInputLayer([32 32 1])
    %卷积层
    convolution2dLayer(5,6,'Padding',2)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'stride',2)
    convolution2dLayer(5,16)
    batchNormalizationLayer
    reluLayer
    maxPooling2dLayer(2,'stride',2)
    convolution2dLayer(5,120)
    batchNormalizationLayer
    reluLayer
    %最终层
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
%%训练神经网络
options = trainingOptions('sgdm',...
    'MaxEpochs',25,...
    'ValidationData',imdsValidation,...
    'ValidationFrequency',5,...
    'Verbose',false,...
    'Plots','training-progress',...
    'ExecutionEnvironment','multi-gpu');%显示训练的进度
%训练神经网络，保存网络
net = trainNetwork(imdsTrain,layers,options);
save 'trainNet' net