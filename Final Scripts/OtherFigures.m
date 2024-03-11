%%
% Bar plots figure
%rows = x axis categories, columns = value for each bar in a category
%3 rows (card,ortho,rad), 4 columns (nlp CW, full CW, nlp MM, full MM)
%adjust color, legend

figure;
set(gca,'FontSize',14)
b = bar(categorical({'Cardiology','Orthopedics','Radiology'}),aucData,'FaceColor','flat');
xlabel('Medical Specialties')
ylabel('AUC')
title('Figure 2: NLP-Only and Full Model Performance on Predicting Citation Count and Mainstream Media Mentions')
ylim([0 1])

b(1).FaceColor = [0.65,0.87,0.95];
b(2).FaceColor = [0.12,0.50,0.76];
b(3).FaceColor = [0.65,0.94,0.77];
b(4).FaceColor = [0.0,0.57,0.49];

xtips1 = b(1).XEndPoints;
ytips1 = b(1).YEndPoints;
labels1 = string(round(b(1).YData,2));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips1 = b(2).XEndPoints;
ytips1 = b(2).YEndPoints;
labels1 = string(round(b(2).YData,2));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips1 = b(3).XEndPoints;
ytips1 = b(3).YEndPoints;
labels1 = string(round(b(3).YData,2));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

xtips1 = b(4).XEndPoints;
ytips1 = b(4).YEndPoints;
labels1 = string(round(b(4).YData,2));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
    'VerticalAlignment','bottom')

legend('NLP Only - Citations','Full Model - Citations','NLP Only - MSM Mentions','Full Model - MSM Mentions')

%%
%Results data tables
yfit = orthoFullCW.predictFcn(data2(end-round(.2*height(data2))-1:end,:));
cardconf = confusionmat(categorical(data2.CitingWorksCount(end-round(.2*height(data2))-1:end)>=median(data2.CitingWorksCount)),yfit);
[stats] = statsOfMeasure(cardconf,1);
LRplus = stats.classes(6,2)/(1-stats.classes(7,2))
LRminus = (1-stats.classes(6,2))/(stats.classes(7,2))

yfit = orthoFullMM.predictFcn(data2(end-round(.2*height(data2))-1:end,:));
cardconf = confusionmat(categorical(data2.cmsm(end-round(.2*height(data2))-1:end)>=1),yfit);
[stats] = statsOfMeasure(cardconf,1);
LRplus = stats.classes(6,2)/(1-stats.classes(7,2))
LRminus = (1-stats.classes(6,2))/(stats.classes(7,2))

%%
%Wordclouds for top 10% scorers, bottom 10% scorers
[~,scores] = cardioCWFull.predictFcn(data2);
[~,scorei] = sort(scores(:,2),'descend');
%scores = [data2.cwScore,data2.cwScore];
% scores = [data2.CitingWorksCount,data2.CitingWorksCount];
figure
t = tiledlayout("flow");
nexttile
wordcloud(data2.Title(scorei(1:round(.1*height(data2)))),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Top 10% of Titles by Predicted Citation Count')

nexttile
wordcloud(data2.Title(scorei(end-round(.1*height(data2)):end)),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Bottom 10% of Titles by Predicted Citation Count')

[~,scores] = cardioMMFull.predictFcn(data2);
[~,scorei] = sort(scores(:,2),'descend');

nexttile
wordcloud(data2.Title(scorei(1:round(.1*height(data2)))),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Top 10% of Titles by Predicted MSM Mentions')

nexttile
wordcloud(data2.Title(scorei(end-round(.1*height(data2)):end)),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Bottom 10% of Titles by Predicted MSM Mentions')

t.TileSpacing = 'compact';
t.Padding = 'tight';
%t.Title ="Figure 4a: Cardiology Word Cloud Reveals Differences in High Influence and Low Influence Predictions across Metrics";

%%
[~,scores] = orthoFullCW.predictFcn(data2);
[~,scorei] = sort(scores(:,2),'descend');
%scores = [data2.cwScore,data2.cwScore];
% scores = [data2.CitingWorksCount,data2.CitingWorksCount];
figure
t = tiledlayout("flow");
nexttile
wordcloud(data2.Title(scorei(1:round(.1*height(data2)))),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Top 10% of Titles by Predicted Citation Count')

nexttile
wordcloud(data2.Title(scorei(end-round(.1*height(data2)):end)),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Bottom 10% of Titles by Predicted Citation Count')

[~,scores] = orthoFullMM.predictFcn(data2);
[~,scorei] = sort(scores(:,2),'descend');

nexttile
wordcloud(data2.Title(scorei(1:round(.1*height(data2)))),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Top 10% of Titles by Predicted MSM Mentions')

nexttile
wordcloud(data2.Title(scorei(end-round(.1*height(data2)):end)),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Bottom 10% of Titles by Predicted MSM Mentions')

t.TileSpacing = 'compact';
t.Padding = 'tight';
%%
[~,scores] = radFullCW.predictFcn(data2);
[~,scorei] = sort(scores(:,2),'descend');
%scores = [data2.cwScore,data2.cwScore];
% scores = [data2.CitingWorksCount,data2.CitingWorksCount];
figure
t = tiledlayout("flow");
nexttile
wordcloud(data2.Title(scorei(1:round(.1*height(data2)))),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Top 10% of Titles by Predicted Citation Count')

nexttile
wordcloud(data2.Title(scorei(end-round(.1*height(data2)):end)),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Bottom 10% of Titles by Predicted Citation Count')

[~,scores] = radFullMM.predictFcn(data2);
[~,scorei] = sort(scores(:,2),'descend');

nexttile
wordcloud(data2.Title(scorei(1:round(.1*height(data2)))),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Top 10% of Titles by Predicted MSM Mentions')

nexttile
wordcloud(data2.Title(scorei(end-round(.1*height(data2)):end)),'HighlightColor',[0 .23 .59],'Color',[0 .52 .59]);
title('Bottom 10% of Titles by Predicted MSM Mentions')

t.TileSpacing = 'compact';
t.Padding = 'tight';

%%
% PCA figure
%x = feature vector 768xN
%%
%ndim = barttest(x,0.05);
x = [featuresTrain;featuresValidation];
[coeff, score,~,~,explained] = pca(x);
sum(explained(1:2))
%explained
%requiredResult = score(:,1:ndim);
%%
rr2d = score(:,1:2);
[~,sorti] = sort(data2.cmsm,'descend');
rr2d = rr2d(sorti(1:10),:);

figure
%scatter(rr2d(:,1),rr2d(:,2))

%text((rr2d(:,1),rr2d(:,2),data2.Title(sorti(1:100)));
t = textscatter(rr2d(:,1),rr2d(:,2),data2.Title(sorti(1:10)),'MaxTextLength',70);
t.FontSize = 18;
% figure
% hold on
% scatter(rr2d(data2.msm<1,1),rr2d(data.msm<1,2),'r');
% scatter(rr2d(data2.msm>=1,1),rr2d(data.msm>=1,2),'b');
% hold off
% 
% figure
% hold on
% scatter(rr2d(data.CitingWorksCount<39,1),rr2d(data.CitingWorksCount<39,2),'r');
% scatter(rr2d(data.CitingWorksCount>=39,1),rr2d(data.CitingWorksCount>=39,2),'b');
% hold off