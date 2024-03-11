# SherBERT
Predicting the future impact of research papers using NLP strategies. Presented at The Aubrey O. Hampton Symposium 2022, RSNA 2022. Published paper is in progress.

# Key Outcomes
- Developed a novel NLP tool able to predict long-term research impact & influence at the time of publication with mean AUC = 0.74
Used novel model to identify trends in medical research influence
- Model performs well on both Citations and Altmetrics, despite being uncorrelated. Model is robust to changes in prevalence & medical specialty.
Creating value across the medical & scientific community
- Scientific media companies: identify and report on medical research likely to be high impact, high influence
- Physicians and scientists: identify the research their patients and colleagues will be seeing, as well as high impact research to remain informed
- Researchers: better frame their research to be understandable to the public and to grab the attention of media
- Research funders: can better allocate resources with less bias

# Future Work & Limitations
- Limited dataset size. Plan to expand to 300k articles.
- Expanding to more medical fields, incorporating date trend info.
- BERT is a generalized model not specifically trained on medical vocabulary. Plan to fine-tune on medical literature.
- Opportunities for further analysis of research clustering – does BERT understand something about the relationships between research we don’t?
