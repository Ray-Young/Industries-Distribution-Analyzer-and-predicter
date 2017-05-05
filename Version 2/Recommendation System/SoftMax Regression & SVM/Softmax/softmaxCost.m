function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)
theta = reshape(theta, numClasses, inputSize);%5*5

data=data';
numCases = size(data, 2);

groundTruth = full(sparse(labels, 1:numCases, 1));
if size(groundTruth,1)<5
    groundTruth=[groundTruth;zeros(1,numCases)];
end

M=exp(theta*data);
M=bsxfun(@rdivide, M, sum(M));

thetagrad = (-1/size(data,2)).*(((groundTruth-(M))*data') + (lambda*theta));

cost = (-1/size(data,2)).*sum(sum(groundTruth.*log(M)));
cost = cost + (lambda/2).*sum(sum(theta.^2));

grad = [thetagrad(:)];
end

