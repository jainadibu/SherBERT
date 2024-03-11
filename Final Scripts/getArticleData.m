%gets article & author info for each entry in a dataset using Pubmed API

for i = 1:height(ortho50k_final)
    %lensidx = indeximpact.idx(i);
    
    %Publication type {'clinical trial';'editorial';'journal article';'journal issue';'letter';'news';'report'}
    ptype = ortho50k_final.PublicationType(i);
%     ops = {'clinical trial';'editorial';'journal article';'journal issue';'letter';'news';'report'};
%     ptype = ops{contains(ops,string(ptype))};
%     if isempty(ptype)
%         ptype = "";
%     end
%     ortho50k_final.ptype(i) = ptype;
    %Number of authors
    num_auths = count(ortho50k_final.Authors(i),";") + 1;
     if isempty(num_auths)
        num_auths = 0;
    end
    ortho50k_final.num_auths(i) = num_auths;
    %Source Country {'Belgium';'Brazil';'Canada';'China';'Colombia';'Czech Republic';'Egypt';'England';'France';'Germany';'Greece';'India';'Iran, Islamic Republic of';'Italy';'Japan';'Netherlands';'New Zealand';'Pakistan';'Poland';'Portugal';'Russian Federation';'Saudi Arabia';'South Africa';'South Korea';'Spain';'Switzerland';'Turkey';'United Arab Emirates';'United Kingdom';'United States'}
%     sc = ortho50k_final.SourceCountry(lensidx);
% %     ops = {'Belgium';'Brazil';'Canada';'China';'Colombia';'Czech Republic';'Egypt';'England';'France';'Germany';'Greece';'India';'Iran, Islamic Republic of';'Italy';'Japan';'Netherlands';'New Zealand';'Pakistan';'Poland';'Portugal';'Russian Federation';'Saudi Arabia';'South Africa';'South Korea';'Spain';'Switzerland';'Turkey';'United Arab Emirates';'United Kingdom';'United States'};
% %     sc = ops{contains(ops,string(sc))};
%     if isempty(sc)
%         sc = "";
%     end
%     ortho50k_final.sc(i) = sc;
    
    apiweb = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term=";
    %Number of articles for first 
    auths = strsplit(ortho50k_final.Authors(i),";");
    ourreq = join([apiweb,auths(1),"%5Bauthor%5D&retmode=json&retmax=10000"],"");
    try
        getdata = webread(ourreq);
    catch
        disp('error')
        continue
    end
    ortho50k_final.fa_articles(i) = length(getdata.esearchresult.idlist);
    %Number of citations for first author
    
    %Number of articles for last author
    ourreq = join([apiweb,auths(end),"%5Bauthor%5D&retmode=json&retmax=10000"],"");
    try
        getdata = webread(ourreq);
    catch
        disp('error')
        continue
    end
    ortho50k_final.la_articles(i) = length(getdata.esearchresult.idlist);
    %Number of citations for last author
    %Number of institutions
    %Journal impact factor - see code on Matlab Drive
    %Quality of first author’s institution
    %# references
%https://eutils.ncbi.nlm.nih.gov/entrez/eutils/elink.fcgi?dbfrom=pubmed&linkname=pubmed_pmc_refs&id=21876726
    ortho50k_final.num_refs(i) = length(strsplit(ortho50k_final.References(i)));
    pause(0.5)
    disp(i)
end

% function [af,cf,al,cl,ptype,num_auths,num_inst,jif,q_inst,sc] = getArticleData(title,lensexport)
% 
%     lensidx = (lensexport.Title == title);
% end