%%
% LDA topic analysis

documents = preprocessText(data2.Title);
documents(1:5)

%%select how many topics
numDocuments = numel(documents);
cvp = cvpartition(numDocuments,'HoldOut',0.1);
documentsTrain = documents(cvp.training);
documentsValidation = documents(cvp.test);

bag = bagOfWords(documentsTrain);
bag = removeInfrequentWords(bag,2);
bag = removeEmptyDocuments(bag);

numTopicsRange = [5 10 15 20 40 50 60 80 100];
for i = 1:numel(numTopicsRange)
    numTopics = numTopicsRange(i);
    
    mdl = fitlda(bag,numTopics, ...
        'Solver','savb', ...
        'Verbose',0);
    
    [~,validationPerplexity(i)] = logp(mdl,documentsValidation);
    timeElapsed(i) = mdl.FitInfo.History.TimeSinceStart(end);
end

figure
yyaxis left
plot(numTopicsRange,validationPerplexity,'+-')
ylabel("Validation Perplexity")

yyaxis right
plot(numTopicsRange,timeElapsed,'o-')
ylabel("Time Elapsed (s)")

legend(["Validation Perplexity" "Time Elapsed (s)"],'Location','southeast')
xlabel("Number of Topics")

%% 
%%do the final LDA
bag = bagOfWords(documents)
bag = removeInfrequentWords(bag,2);
bag = removeEmptyDocuments(bag)

rng("default")
numTopics = 5;
mdl = fitlda(bag,numTopics,Verbose=0);

%%
%use model to create score for each document

topidx = predict(mdl,documents);
topidx(:,2) = data2.msm;
topidx(:,3) = data2.CitingWorksCount;

msm = [];
for i = 1:numTopics
msm = [msm,mean(topidx(topidx(:,1) == i,2))];
end

cwc = [];
for i = 1:numTopics
cwc = [cwc,mean(topidx(topidx(:,1) == i,3))];
end

figure
t = tiledlayout("flow");
title(t,"LDA Topics")

for i = 1:numTopics
    nexttile
    wordcloud(mdl,i);
    title("Topic: " + i + " MSM: " + msm(i) + " CW: " + cwc(i))
end



function documents = preprocessText(textData)

% Tokenize the text.
documents = tokenizedDocument(textData);

% Lemmatize the words.
documents = addPartOfSpeechDetails(documents);
documents = normalizeWords(documents,'Style','lemma');

% Erase punctuation.
documents = erasePunctuation(documents);

% Remove a list of stop words.
documents = removeStopWords(documents);

% Remove words with 2 or fewer characters
documents = removeShortWords(documents,2);
%documents = removeLongWords(documents,15);

end