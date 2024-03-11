XScores = predict(net,featuresTrain);
YScores = predict(net,featuresValidation);

dataTrain.mmScore = XScores(:,2);
dataValidation.mmScore = YScores(:,2);

data2 = [dataTrain;dataValidation];

for i = 1:height(data2)
code = countrycodes(ismember(countrycodes(:,1),string(data2.SourceCountry(i))),2);
    if ~isempty(code)
     data2.scCode(i) = code;
    end
end

data2.scCode(data2.SourceCountry == "England") = "GB";
data2.scCode(data2.SourceCountry == "South Korea") = "KR";
unique(data2.SourceCountry(ismissing(data2.scCode)))