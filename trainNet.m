clc
clear 
close all
%%��������
imageTrain = imageDatastore('trainSet',...
    'IncludeSubfolders',true,'LabelSource','foldernames');%�����ļ���������Ϊ���ݱ��
%%���ݼ�ͼ����
countEachLabel(imageTrain)
numTrainFiles = 0.2;%ÿһ��������22��������ȡ17��������Ϊѵ������
[imdsTrain,imdsValidation] = splitEachLabel(imageTrain,numTrainFiles,'randomized');
%%������������Ľṹ
layers = [
    %�����
    imageInputLayer([32 32 1])
    %�����
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
    %���ղ�
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer];
%%ѵ��������
options = trainingOptions('sgdm',...
    'MaxEpochs',25,...
    'ValidationData',imdsValidation,...
    'ValidationFrequency',5,...
    'Verbose',false,...
    'Plots','training-progress',...
    'ExecutionEnvironment','multi-gpu');%��ʾѵ���Ľ���
%ѵ�������磬��������
net = trainNetwork(imdsTrain,layers,options);
save 'trainNet' net