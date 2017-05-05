inputSize = 5; 
numClasses = 5;    
lambda = 1e-4; 

tmp=csvread('average.csv',1,2);
rate=csvread('rate_c.csv');
rate=rate(:,1:3);
num_users=200;
link(rate,tmp,num_users);
res=zeros(num_users,1);
for i =1:num_users
%traning
filename=strcat('./user_rating/user',int2str(i),'.csv');

data = csvread(filename);
labels = data(:,8);
inputData = data(:,3:7);

theta = 0.005 * randn(numClasses * inputSize, 1);
[cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, inputData, labels);
                                     
options.maxIter = 1000;
softmaxModel = softmaxTrain(inputSize, numClasses, lambda, ...
                            inputData, labels, options);

%testing
testdata=csvread(filename);
labels = testdata(:,8);
inputData = testdata(:,3:7);

pred = softmaxPredict(softmaxModel,inputData,labels);
acc = pred.acc;
fprintf('Accuracy of user %i: %0.3f%%\n', i, acc * 100);
res(i,1)=acc;
end
mean(res(:,1))