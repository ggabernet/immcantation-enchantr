library(enchantr)
library(airr)
library(dplyr)
library(scoper)
library(dowser)

sessionInfo()

db <- read_rearrangement("tests/data-tests/clonal_analysis/clonal_results.tsv")

#Filter NAs since otherwise scoper does not run
db_sc <- db %>% filter(!is.na(cell_id))

db_cloned <- hierarchicalClones(db_sc, 
                                0.1, 
                                method='nt',
                                linkage='single', ``
                                normalize="len",
                                junction="junction", 
                                v_call="v_call", 
                                j_call="j_call", 
                                clone="clone_id", 
                                fields='subject_id',
                                cell_id='cell_id', 
                                locus="locus", 
                                first=FALSE, 
                                cdr3=FALSE, 
                                mod3=FALSE, 
                                max_n=0, 
                                nproc=1,
                                verbose=FALSE, 
                                log=NULL,
                                summarize_clones=FALSE)

db_resolved <- db_cloned %>%
    group_by(clone_id) %>%
    resolveLightChains(nproc=1) #%>%
    #mutate(clone_id = clone_subgroup)
