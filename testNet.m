clear
load trainNet
%%������ݣ��ļ����Ʒ�ʽ�����й��죩
testSet = imageDatastore('testSet',...
    'IncludeSubfolders',true,'LabelSource','foldernames');%�����ļ���������Ϊ���ݱ��
%%%ʹ��������з��ಢ����׼ȷ��
%��д����
testPre = classify(net,testSet);
testTureLabe= testSet.Labels;
%������ȷ��
accuracy = sum(testPre == testTureLabe)/numel(testTureLabe)
%����Ԥ����
figure;
nSample = 10;
ind = randperm(size(testPre,1),nSample);
for i = 1:nSample
    subplot(2,fix((nSample+1)/2),i)
    imshow(char(testSet.Files(ind(i))))
    title(['Ԥ�⣺' char(testPre(ind(i)))])
    if char(testPre(ind(i))) ==char(testTureLabe(ind(i)))
        xlabel(['��ʵ:' char(testTureLabe(ind(i)))],'Color','b')
    else
        xlabel(['��ʵ:' char(testTureLabe(ind(i)))],'color','r')
    end
end
