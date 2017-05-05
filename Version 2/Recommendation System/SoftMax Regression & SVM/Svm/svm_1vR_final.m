num_user=200;
for x=1:num_user
filename=strcat('./user_rating/user',int2str(x),'.csv');
data=load(filename);

C=inf;
X=data(:,3:7);
y=data(:,8);

for l =1:5
    temp = find(y~=l);
    temp_y1=ones(size(y,1),1);
    temp_y1(temp)=-1;
    svm = svmTrain(X,temp_y1,C);
    str=int2str(l);
    svm_name=strcat('./1vr/user', int2str(x),'_1vr_',str,'.mat');
    save(svm_name,'svm');
end

%1 vs rest testing
score=zeros(size(X,1),5);
res=zeros(num_user,1);
for m=1:5
    tmp=int2str(m);
    mysvm=strcat('./1vr/user', int2str(x),'_1vr_',tmp,'.mat');
    svm=load(mysvm);
    temp1 = find(y~=m);
    temp_y2=ones(size(X,1),1);
    temp_y2(temp1)=-1;
    result = svmTest(svm.svm, X, temp_y2);
    score(:,m)=result.score;
    [M,induce]=max(score,[],2);
    accuracy=size(find(double(induce==y)))/size(y);
end
fprintf('accuracy of user%i is %f\n',x,accuracy);
res(x,1)=accuracy;
end
mean(res(x,1))