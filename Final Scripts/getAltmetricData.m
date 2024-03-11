%Gets all Altmetrics data given an imported CSV file from Lens.org (Run
%this first)

%metrics = zeros(height(ortho50k),6);
for i = 1:91
    apiweb = "https://api.altmetric.com/v1/doi/";
%     doi = lensexport.DOI(indeximpact.idx(i));
%     if length(doi) > 1
%         doi = doi(1);
%     end
    doi = ortho50k.DOI(i);
    ourreq = join([apiweb,doi],'');
    try
        getdata = webread(ourreq);
    catch
        disp(join(['error ',num2str(i)],""))
        metrics(i,:) = [12345,12345,12345,12345,12345,12345];
        continue
    end
    cscore = getdata.score;
    if isfield(getdata,'cited_by_msm_count')
        cmsm = getdata.cited_by_msm_count;
    else
        cmsm = 0;
    end
    if isfield(getdata,'cited_by_tweeters_count')
        ctweets = getdata.cited_by_tweeters_count;
    else
        ctweets = 0;
    end
    if isfield(getdata,'context')
        crankall = getdata.context.all.pct;
        cranksim = getdata.context.similar_age_3m.pct;
        crankjour = getdata.context.similar_age_journal_3m.pct;
    else
        crankall = 0;
        cranksim = 0;
        crankjour = 0;
    end
    metrics(i,:) = [cscore,cmsm,ctweets,crankall,cranksim,crankjour];
    pause(0.2)
    if ~mod(i,500)
        disp(i)
    end
end

ortho50k.cscore = metrics(:,1);
ortho50k.cmsm = metrics(:,2);
ortho50k.ctweets = metrics(:,3);
ortho50k.crankall = metrics(:,4);
ortho50k.cranksim = metrics(:,5);
ortho50k.crankjour = metrics(:,6);