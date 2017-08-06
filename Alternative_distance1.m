
searchpath='P03.Learn2';
datafolder=['/Users/ravic/Box Sync/Boorman Lab/Experiments/SocialSpace/4.Results/Bhv results/Matfiles/' searchpath];
cd (datafolder);
lists=dir('SS*.mat');


% number of trials for each multiplied distance between two faces
num_1=0; num1=0; num_2=0; num2=0; num_3=0; num3=0; num0=0; 
% all data for a multiplied distance (xxx_1 means the multiplied distance
% is minus 1 and xxx1 means the multiplied distance is positive 1)
dataRT_1=[]; dataRT1=[]; dataRT_2=[]; dataRT2=[]; dataRT_3=[]; dataRT3=[]; dataRT0=[];
% accuracy for a multiplied distance
dataAcc_1=[]; dataAcc1=[]; dataAcc_2=[]; dataAcc2=[]; dataAcc_3=[]; dataAcc3=[]; dataAcc0=[];

for sub=1:length(lists)
    slist=lists(sub).name;
    load(slist);
    for i=1:length(Learn.Face1)
        if Learn.AgT(i)==1 
            % the popularity level of face 1
            if Learn.Face1(i)==1 | Learn.Face1(i)==5 | Learn.Face1(i)==9 | Learn.Face1(i)==13
                Learn.Al1(i,1)=1; 
            elseif Learn.Face1(i)==2 | Learn.Face1(i)==6 | Learn.Face1(i)==10 | Learn.Face1(i)==14
                Learn.Al1(i,1)=2;
            elseif Learn.Face1(i)==3 | Learn.Face1(i)==7 | Learn.Face1(i)==11 | Learn.Face1(i)==15
                Learn.Al1(i,1)=3;
            else
                Learn.Al1(i,1)=4;
            end
            % the popularity level of face 2
            if Learn.Face2(i)==1 | Learn.Face2(i)==5 | Learn.Face2(i)==9 | Learn.Face2(i)==13
                Learn.Al2(i,1)=1;
            elseif Learn.Face2(i)==2 | Learn.Face2(i)==6 | Learn.Face2(i)==10 | Learn.Face2(i)==14
                Learn.Al2(i,1)=2;
            elseif Learn.Face2(i)==3 | Learn.Face2(i)==7 | Learn.Face2(i)==11 | Learn.Face2(i)==15
                Learn.Al2(i,1)=3;
            else
                Learn.Al2(i,1)=4;
            end
        else
            % the competence level of face 1
            if Learn.Face1(i)>=1 & Learn.Face1(i)<=4
                Learn.Al1(i,1)=1;
            elseif Learn.Face1(i)>=5 & Learn.Face1(i)<=8
                Learn.Al1(i,1)=2;
            elseif Learn.Face1(i)>=9 & Learn.Face1(i)<=12
                Learn.Al1(i,1)=3;
            else
                Learn.Al1(i,1)=4;
            end
            % the competence level of face 2
            if Learn.Face2(i)>=1 & Learn.Face2(i)<=4
                Learn.Al2(i,1)=1;
            elseif Learn.Face2(i)>=5 & Learn.Face2(i)<=8
                Learn.Al2(i,1)=2;
            elseif Learn.Face2(i)>=9 & Learn.Face2(i)<=12
                Learn.Al2(i,1)=3;
            else
                Learn.Al2(i,1)=4;
            end
        end
        
        Learn.AlDis(i,1)=Learn.Al1(i)-Learn.Al2(i); % the alternative difference
        Learn.absAlDis(i,1)=abs(Learn.AlDis(i,1)); % the absolute value of the alternative difference
        Learn.AgTDis(i,1)=Learn.A1(i)-Learn.A2(i); % distance (neither alternative nor absolute)
        Learn.Product(i,1)=Learn.AlDis(i,1)*Learn.AgTDis(i,1); % multiplied distance
        
        % data sorting according to multiplied distance
        switch Learn.Product(i,1)
            case -1
                num_1=num_1+1;
                dataRT_1=[dataRT_1, Learn.RT(i)];
                dataAcc_1=[dataAcc_1, Learn.Acc(i)];
            case 1
                num1=num1+1;
                dataRT1=[dataRT1, Learn.RT(i)];
                dataAcc1=[dataAcc1, Learn.Acc(i)];
            case -2
                num_2=num_2+1;
                dataRT_2=[dataRT_2, Learn.RT(i)];
                dataAcc_2=[dataAcc_2, Learn.Acc(i)];
            case 2
                num2=num2+1;
                dataRT2=[dataRT2, Learn.RT(i)];
                dataAcc2=[dataAcc2, Learn.Acc(i)];
            case -3
                num_3=num_3+1;
                dataRT_3=[dataRT_3, Learn.RT(i)];
                dataAcc_3=[dataAcc_3, Learn.Acc(i)];
            case 3
                num3=num3+1;
                dataRT3=[dataRT3, Learn.RT(i)];
                dataAcc3=[dataAcc3, Learn.Acc(i)];
            otherwise
                num0=num0+1;
                dataRT0=[dataRT0, Learn.RT(i)];
                dataAcc0=[dataAcc0, Learn.Acc(i)];
        end
    end
end

    num=[num_3,num_2,num_1,num0,num1,num2,num3];
    % total RT, accuracy, and mean RT, accuracy for each multiplied distance
    totalRT=[sum(dataRT_3),sum(dataRT_2),sum(dataRT_1),sum(dataRT0),sum(dataRT1),sum(dataRT2),sum(dataRT3)];
    totalAcc=[sum(dataAcc_3),sum(dataAcc_2),sum(dataAcc_1),sum(dataAcc0),sum(dataAcc1),sum(dataAcc2),sum(dataAcc3)];
    meanRT=totalRT./num;
    meanAcc=totalAcc./num;
    
    % standard error for RT and accuracy
    seRT(1)=std(dataRT_3)/sqrt(num_3-1);
    seRT(7)=std(dataRT3)/sqrt(num3-1);
    seRT(2)=std(dataRT_2)/sqrt(num_2-1);
    seRT(6)=std(dataRT2)/sqrt(num2-1);
    seRT(3)=std(dataRT_1)/sqrt(num_1-1);
    seRT(5)=std(dataRT1)/sqrt(num1-1);
    seRT(4)=std(dataRT0)/sqrt(num0-1);
    
    seAcc(1)=std(dataAcc_3)/sqrt(num_3-1);
    seAcc(7)=std(dataAcc3)/sqrt(num3-1);
    seAcc(2)=std(dataAcc_2)/sqrt(num_2-1);
    seAcc(6)=std(dataAcc2)/sqrt(num2-1);
    seAcc(3)=std(dataAcc_1)/sqrt(num_1-1);
    seAcc(5)=std(dataAcc1)/sqrt(num1-1);
    seAcc(4)=std(dataAcc0)/sqrt(num0-1);
    
    %bar graph
    x=[-3:3];
    bar(x,meanRT)
    hold on;
    errorbar(x,meanRT,seRT,'.');
    title('Mean Reaction Time')
    figure(2)
    bar(x,meanAcc)
    SEacc=std(meanAcc)/sqrt(numel(meanAcc)-1);
    hold on;
    errorbar(x,meanAcc,seAcc,'.');
    title('Mean Accuracy')
    
  