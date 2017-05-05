function link(rating,training,num_users)
Max=max(rating(:,1));
if num_users<=Max
for i=1:num_users
    %link user with rating
    index= rating(:,1)==i;
    user_rating=rating(index,:);
    jobId=user_rating(:,2);
    final=zeros(size(jobId,1),8);
 
    for j=1:size(jobId,1)
        induce=jobId(j,1);
        if(induce<=size(training,1))
            tmp=[user_rating(j,1:2) training(induce,1:5) user_rating(j,3)];
            final(j,:)=tmp;
        end
        
    end
    filename=strcat('./user_rating/user',int2str(i),'.csv');
    csvwrite(filename,final);
end
else
    fprintf('Invalid number\n');
end
