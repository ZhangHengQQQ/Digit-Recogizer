clear
load handwritten

trainFolder = [cd,'/trainSet']; 
mkdir(trainFolder);
for j=0:9
    mkdir([trainFolder,'/',num2str(j)]);
end

testFolder = [cd,'/testSet']; 
mkdir(testFolder);
for j=0:9
    mkdir([testFolder,'/',num2str(j)]);
end

n=size(train_image,3);
for i=1:n
    imwrite(imresize(train_image(:,:,i),[32,32]),[cd,'\trainSet\',num2str(train_lab(i)),'\',num2str(i),'.bmp']);
end

n=size(test_image,3);
for i=1:n
    imwrite(imresize(test_image(:,:,i),[32,32]),[cd,'\testSet\',num2str(test_lab(i)),'\',num2str(i),'.bmp']);
end

