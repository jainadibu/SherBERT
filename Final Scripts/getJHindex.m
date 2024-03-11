for i = 1:height(ortho50k_final)

    cissn = string(ortho50k_final.ISSNs(i));
    cissn = strsplit(cissn,";");
    cissn = cissn(1);
    getdat = webread(join(['https://www.resurchify.com/find/?query=',cissn],""));
    getdat = strsplit(getdat,"h-Index:");
    getdat = strsplit(getdat{end},"<");
    ortho50k_final.jif(i) = str2double(getdat{1});
    disp(i)
end