---
title: "Analysis of expression Proteomics data in R"
author: "Charlotte Hutchings, Lisa Breckels"
date: today
number-sections: false
---

## Overview 

These materials focus on expression proteomics, which aims to characterise the protein diversity and abundance in a particular system. 
You will learn about the bioinformatic analysis steps involved when working with these kind of data, in particular several dedicated proteomics Bioconductor packages, part of the R programming language.
We will use real-world datasets obtained from label free quantitation (LFQ) as well as tandem mass tag (TMT) mass spectrometry. 
We cover the basic data structures used to store and manipulate protein abundance data, how to do quality control and filtering of the data, as well as several visualisations. 
Finally, we include statistical analysis of differential abundance across sample groups (e.g. control vs. treated) and further evaluation and biological interpretation of the results via gene ontology analysis. 

::: {.callout-tip}
### Learning Objectives

You will learn about:

- How mass spectrometry can be used to quantify protein abundance and some of the methods used for peptide quantitation.
- The bioinformatics steps involved in processing and analysing expression proteomics data.
- How to assess the quality of your data, deal with missing values and summarise peptide-level data to protein-level.
- How to perform differential expression analysis to compare protein abundances between different groups of samples.
:::


### Target Audience

Proteomics practitioners or data analysts/bioinformaticians that would like to learn how to use R to analyse proteomics data.


### Prerequisites

* Basic understanding of mass spectometry.
  * Watch this [iBiology video](https://youtu.be/eNKMdVMglvI) for an excellent overview. 
* A working knowledge of R and the tidyverse.
* Familiarity with other Bioconductor data classes, such as those used for RNA-seq analysis, is useful but not required. 

<!-- Training Developer note: comment the following section out if you did not assign levels to your exercises -->
### Exercises

Exercises in these materials are labelled according to their level of difficulty:

| Level | Description |
| ----: | :---------- |
| {{< fa solid star >}} {{< fa regular star >}} {{< fa regular star >}} | Exercises in level 1 are simpler and designed to get you familiar with the concepts and syntax covered in the course. |
| {{< fa solid star >}} {{< fa solid star >}} {{< fa regular star >}} | Exercises in level 2 combine different concepts together and apply it to a given task. |
| {{< fa solid star >}} {{< fa solid star >}} {{< fa solid star >}} | Exercises in level 3 require going beyond the concepts and syntax introduced to solve new problems. |


## Authors
<!-- 
The listing below shows an example of how you can give more details about yourself.
These examples include icons with links to GitHub and Orcid. 
-->

About the authors:

- **Charlotte Hutchings**
  <a href="https://github.com/Charl-Hutchings" target="_blank"><i class="fa-brands fa-github" style="color:#4078c0"></i></a>  
  _Affiliation_: Department of Biochemistry, University of Cambridge  
  _Roles_: writing - original draft; conceptualisation; coding
- **Lisa Breckels**
  <a href="https://orcid.org/0000-0001-8918-7171" target="_blank"><i class="fa-brands fa-orcid" style="color:#a6ce39"></i></a> 
  <a href="https://github.com/lmsimp" target="_blank"><i class="fa-brands fa-github" style="color:#4078c0"></i></a>  
  _Affiliation_: Department of Biochemistry, University of Cambridge  
  _Roles_: writing - writing - original draft; conceptualisation; coding


## Citation

<!-- We can do this at the end -->

Please cite these materials if:

- You adapted or used any of them in your own teaching.
- These materials were useful for your research work. For example, you can cite us in the methods section of your paper: "We carried our analyses based on the recommendations in _TODO_.".

You can cite these materials as:

> TODO

Or in BibTeX format:

```
@Misc{,
  author = {},
  title = {},
  month = {},
  year = {},
  url = {},
  doi = {}
}
```


## Acknowledgements

<!-- if there are no acknowledgements we can delete this section -->

- List any other sources of materials that were used.
- Or other people that may have advised during the material development (but are not authors).
