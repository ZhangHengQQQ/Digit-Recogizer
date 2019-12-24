clear
load trainNet
%%标记数据（文件名称方式，自行构造）
testSet = imageDatastore('testSet',...
    'IncludeSubfolders',true,'LabelSource','foldernames');%采用文件夹名称作为数据标记
%%%使用网络进行分类并计算准确性
%手写数据
testPre = classify(net,testSet);
testTureLabe= testSet.Labels;
%计算正确率
accuracy = sum(testPre == testTureLabe)/numel(testTureLabe)
%绘制预测结果
figure;
nSample = 10;
ind = randperm(size(testPre,1),nSample);
for i = 1:nSample
    subplot(2,fix((nSample+1)/2),i)
    imshow(char(testSet.Files(ind(i))))
    title(['预测：' char(testPre(ind(i)))])
    if char(testPre(ind(i))) ==char(testTureLabe(ind(i)))
        xlabel(['真实:' char(testTureLabe(ind(i)))],'Color','b')
    else
        xlabel(['真实:' char(testTureLabe(ind(i)))],'color','r')
    end
end
