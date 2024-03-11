function score = testBFENet(net,rawstr,bertM)
%can be 1 or any number of strings
    encodedstr = encode(bertM.Tokenizer,rawstr);
    dsXTrain = arrayDatastore(encodedstr,"OutputType","same");
    miniBatchSize = length(rawstr);
    paddingValue = bertM.Tokenizer.PaddingCode;
    maxSequenceLength = bertM.Parameters.Hyperparameters.NumContext;
    
    mbqTrain = minibatchqueue(dsXTrain,1,...
        "MiniBatchSize",miniBatchSize, ...
        "MiniBatchFcn",@(X) preprocessPredictors(X,paddingValue,maxSequenceLength));
    
    
    reset(mbqTrain);
    featuresTrain = [];
    while hasdata(mbqTrain)
        X = next(mbqTrain);
        features = bertEmbed(X,bertM.Parameters);
        featuresTrain = [featuresTrain gather(extractdata(features))];
    end
    score = predict(net,featuresTrain');
    score = score(:,2);
end

function Y = bertEmbed(X,parameters,args)

arguments
    X
    parameters
    args.DropoutProbability = 0
end

dropoutProbabilitiy = args.DropoutProbability;

Y = bert.model(X,parameters, ...
    "DropoutProb",dropoutProbabilitiy, ...
    "AttentionDropoutProb",dropoutProbabilitiy);

Y = mean(Y,2);
Y = squeeze(Y);

end

function X = preprocessPredictors(X,paddingValue,maxSeqLen)

X = truncateSequences(X,maxSeqLen);
X = padsequences(X,2,"PaddingValue",paddingValue);

end