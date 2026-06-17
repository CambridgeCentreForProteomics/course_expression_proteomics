### Gene Ontology (GO) enrichment analysis

One of the common methods used to probe the biological relevance of proteins
with significant changes in abundance between conditions is to carry out Gene
Ontology (GO) enrichment, or over-representation, analysis.

The Gene Ontology consortium have defined a set of hierarchical descriptions to
be assigned to genes and their resulting proteins. These descriptions are split
into three categories: cellular components (CC), biological processes (BP) and
molecular function (MF). The idea is to provide information about a protein's
subcellular localisation, functionality and which processes it contributes to
within the cell. Hence, the overarching aim of GO enrichment analysis is to
answer the question:

*"Given a list of proteins found to be differentially abundant in my phenotype of interest, what are the cellular components, molecular functions and biological processes involved in this phenotype?".*

Unfortunately, just looking at the GO terms associated with our differentially
abundant proteins is insufficient to draw any solid conclusions. For example, if
we find that 120 proteins significantly downregulated in our condition of interest
are annotated with the GO term "kinase activity", it may
seem intuitive to conclude that reducing kinase activity is important for the
phenotype of interest. However, if 90% of all proteins in the cell were kinases (an extreme
example), then we might expect to discover a high representation of the "kinase
activity" GO term in any protein list we end up with.

This leads us to the concept of an over-representation analysis. We wish to ask
whether any GO terms are over-represented (i.e., present at a higher frequency
than expected by chance) in our lists of differentially abundant proteins. In
other words, we need to know how many proteins with a GO term *could* have
shown differential abundance in our experiment vs. how many proteins with this
GO term *did* show differential abundance in our experiment.
