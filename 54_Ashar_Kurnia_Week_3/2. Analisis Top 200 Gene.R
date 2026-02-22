library(readr)
library(dplyr)
df <- read_tsv("GSE51808.top.table.tsv")

# Gene filter
upregulated <- df %>% 
  filter(logFC > 1, adj.P.Val < 0.05) %>% 
  na.omit(upregulated)

downregulated <- df %>% 
  filter(logFC < -1, adj.P.Val < 0.05) %>% 
  na.omit(dowregulated)


#Top200 Gene
top_200_upregulated <- upregulated %>% 
  arrange(desc(logFC)) %>%
  
  slice_head(n = 200)


top_200_downregulated <- downregulated %>% 
  arrange(desc(logFC)) %>%
  slice_head(n = 200)

 
# Clean "///" symbol
top_200_upregulated$Gene.symbol <- sub("/{3,}.*", "", top_200_upregulated$Gene.symbol)
top_200_downregulated$Gene.symbol <- sub("/{3,}.*", "", top_200_downregulated$Gene.symbol)

#Export
library(xlsx)

write_xlsx(
  list(
    dataframe = df,
    upregulated= top_200_upregulated,
    downregulated = top_200_downregulated
  ),
  "Top200Gene_results.xlsx"
)