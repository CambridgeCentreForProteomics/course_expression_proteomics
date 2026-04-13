We now have log protein level abundance data to which we could apply a parametric
statistical test. However, to perform a statistical test and discover whether any
proteins differ in abundance between conditions, we first
need to account for non-biological variance that may contribute to any differential
abundance. Such variance can arise from experimental error or technical variation,
although the latter is much more prominent when dealing with label-free DDA data,
compared to TMT DDA or LFQ DIA.

Normalisation is the process by which we account for non-biological variation in
protein abundance between samples and attempt to return our quantitative data
back to its 'normal' condition i.e., representative of how it was in the original
biological system. There are various methods that exist to normalise expression
proteomics data and it is necessary to consider which of these to apply on a
case-by-case basis. Unfortunately, there is not currently a single normalisation
method which performs best for all quantitative proteomics datasets.
