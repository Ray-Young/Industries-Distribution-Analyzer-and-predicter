function pred = softmaxPredict(softmaxModel, data, labels)
theta = softmaxModel.optTheta;  
data=data';
predict = zeros(1, size(data, 2));

M = exp(theta*data);
M = bsxfun(@rdivide, M, sum(M));
[temp predict] = max(M);

comp=[predict' labels];
count=0;
for i=1:size(comp,1)
    if abs(comp(i,1)-comp(i,2))<=1
        count=count+1;
    end
end

pred.predict = predict;
pred.acc=count/size(comp,1);

end

