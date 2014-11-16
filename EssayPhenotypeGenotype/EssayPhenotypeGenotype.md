# How does a genotype lead to a phenotype? Or: How to conclude a phenotype for a new species?

## Introduction

The techniques in biology to obtain the genome, transcriptome, proteome or others omes, are improving. This can be attributed to, amongst others, improvements in nanotechnology (e.g. nanopore sequencing) and informatics (e.g. improved algorithms). One example is the 454 pyrosequencing technique, that was an order-of-magnitude improvement over the other sequencing techniques, yet was already rendered obsolete within a couple of years! 

## Research question

Is genetics trivial to do nowadays? Or: what is left to do for researchers, given the improvements of technology? 

This essay tries to give an answer to this question by starting with an imaginary species that does not have its genome sequenced. We can observe it, culture or capture it, and analyze its cells. This essay starts bottom-up (that is: from the techniques) to see what is left for researchers to do, given a fair amount of money. In practice, I would not recommend this approach, as I'd suggest to find out if a focal phenotype has a genetic basis first. 

This essay will describe the steps to take:
 * Obtaining the species its genome sequence
 * Finding the species its genes
 * Mapping genotype to phenotype
   * for Mendelian and quantitative traits
   * for a plastic (in gene expression) trait

For brevity, some steps are summarized in such a way they appear to be trivially easy. They are not. Yet.

## Obtaining the species its genome sequence

To obtain a species its genome sequence, its purified DNA is needed. The protocol of obtaining enough DNA can take some time to develop, but also the amount of purified DNA needed for a successful sequencing run is decreasing in time. 

Having the species its purified DNA, which sequencing technique should be used? Personally, I'd say: the techniques of tomorrow, as these techniques have not seemed to reach a plateau in speed and cost-effectiveness.

Having a genome sequence is a good start. From the sequence, we can look for genes. Note that a sequence is not perfect: there is no technique with 100% accuracy yet, but sequencing the same DNA multiple times can let the accuracy increase asymptotically to 100%. But a sequence does not need to be that accurate: it will be compared with sequences of other species, and those sequences will be more different than the sequence obtained differs from the original DNA.

Having a genome sequence, genes can be inferred.

## Finding the species its genes

The first step in finding a gene within a sequence is looking for open reading frames (ORFs): a sequence starting with a start codon (a codon consists out of three nucleotides), ending with a stop codon, and having some length in between. The genetic code enables each nucleotide to be a member of maximally six ORFs, as it can be either the first, second and third element of a codon, and DNA can be transcribed in both directions.

Every ORF can be compared to other DNA sequences directly, but this might give too much false negatives, due to the redundancy in the genetic code (64 nucleotide triplets translate to 20 amino acids). Converting the ORF to a protein sequence will give a more appropriate resolution. This protein sequence can be compared to a protein database. If there is no match found, or only matches with proteins of unknown function, you just have found something new to discover. You can choose to zoom in on this gene and find out what the protein it codes for does. 

Having found one or more protein that match the ORF its protein product, there might be two surprises:
  (1) polycistrony: especially in prokaryotes, it is common that one start codon codes for multiple proteins 
  (2) intron-exon structure: especially in eukaryotes, it is common to find DNA sequences that get transcribed to RNA, yet removed (spliced) before translation .

This step, finding all ORFs, can be automated. It is not. Yet.

## Mapping genotype to phenotype

It is time to investigate the phenotype, now the genome sequence is known. Problematically, the phenotype its connection to the genotype can be from direct to absent! 

A focal phenotype, a trait, can be: 
 * A Mendelian traits: one gene codes for the trait
 * A quantitative trait: multiple genes code for a trait value
 * A plastic trait, caused by change in gene expression by some external factor
 * An epigenetic trait, inherited from ancestor by non-genetic means
 * A hologenomic trait, induced by other organisms in a steady co-occurence 
 * An environmental trait, caused by abiotic factors or stochastic biotic factors

Note that only the first two trait types (Mendelian and quantitative) are mapped to the genome! For plastic (as in gene expression) traits, the transcriptome (the complete array of RNAs) is needed to elucidate the relation between genotype and phenotype. Epigenetic traits may be detected easier by having a transcriptome, but will require more information. If a trait is caused by other organisms, phylogenies of both species are needed to assure this (only species that associate with the focal species will have the same phylogeny). If a trait is caused by the environment only (e.g. T-shirt color in humans), either it is not interesting to study (T-shirt color is not inherited), or a genetic link between trait and the behavior causing this trait can be searched for (What causes a human to buy and wear orange T-shirts?).

In this essay, I will focus on the first three types of traits.

## Mapping genotype to phenotype for Mendelian and quantitive traits

Both Mendelian and quantitative traits can be found using quantitive trait loci (QTL) analysis. Some may argue that QTL analysis may be too much work for a simple Mendelian trait, but QTL analysis is a way to find out if a trait (of unknown genetic basis) is Mendelian! 

Having our focal species its genome, the connection between genotype and phenotype can be made by 
 * Breeding two individuals that differ in the focal trait (optionally: inbreeding)
 * creating a gene map 

Having two individuals that differ in the focal trait is a must. Their (many) offspring can then be scored for trait value. If offspring with a high trait value often have a significantly higher (or lower) allele frequency, we can make the connection between phenotype and that allele. This is easiest for individuals that are inbred to near-homozygosity. And even for inbred lines, you'll need about 500 individuals for some statistical power. We need that much offspring, because the offspring must have much variation from recombination, as recombination gives rise to genetic distance.

To find out which alleles are passed to the offspring, a gene map is needed. A gene map contains positions of markers on the genome. Markers are DNA sequences that can be detected reliably and preferable reside on one single locus. In this essay, I choose to use single-nucleotide polymorphisms (SNPs) as markers.

Wouldn't I have limited this essay to one genome sequence, finding SNPs would have been trivial: create another genome sequence from an individual with different trait value and compare the sequences for unique single-nucleotide differences. From these differences, create molecular beacons or a specialized SNP microarray.

Having only one genome sequence, I suggest to take a general SNP microarray. Two individuals that differ in a trait will have different SNPs (assuming there are enough SNPs). Because the SNP microarray its SNPs are known, the reacting SNPs can be mapped back to their positions on the genome. SNPs that occur only a single locus will be most useful.

Having our gene map, SNPs and observed trait values, traits can be mapped to the genome. The presence of some SNPs will cause a higher (or lower) trait value. Thanks to the gene map it can be said which piece(s) of DNA cause a higher (or lower) trait value: the pieces associated with those SNPSs. In a very simplified example, imagine a trait being associated equally with two SNPs that are located ten kb from each other, than the locus is probably between those two SNPs.

Mapping genotype to phenotype for Mendelian and quantitive traits is a lot of work. Especially the number of individuals needed for some statistical power is a major drawback. But its steps are straightforward.

## Mapping genotype to phenotype for a plastic (in gene expression) trait

Some phenotypes are plastic: they change due to a change in environment. The mechanism behind this may be that the environment triggers (or inhibits) a gene its expression. For plastic traits, genetically identical individuals may have a different trait value. In such a case, having a genome sequence is of no direct value.

When phenotype differences are caused by different gene expression patterns, the RNA is the place to start an investigation. The whole RNA can be sequenced using RNA-seq. Two individuals with different trait expression must have their RNA sequenced. Note that RNA is local, so cells that are related to the trait its expression must be chosen. From the RNA-seq (which measures the difference in gene expression) RNAs can be found that are significantly more (or less) expressed. Note that RNA-seq is a fragile process and even handling the two individuals differently can have a huge impact! Even RNA-seq is (still) expensive, adding at least one replicate is therefore advised. Additionally, different algorithms that extract the true values from the raw RNA-seq results (by filtering out experimental noise) can lead to different conclusions. So take care when selecting RNAs that correlate strongly to a trait.

Having RNAs that correlate strongly to a trait, does not mean that these cause the trait. Traits are typically regulated by gene networks, where an increase of one RNA can cause a change in expression of multiple, possibly unrelated, genes.   

These RNA strands can be converted in silico to their DNA counterparts. Having the genome sequence, it can be deduced where on the DNA a change in gene expression took place. To find the right gene (that has a causal relation with the trait) from these candidates, more research is needed. With some luck, the genes are annotated in a gene database. Without such luck, making knock-out mutants is the next step: for each gene candidate, a mutant is created that has no change in expression for that gene. If the focal trait loses its plasticity, the gene knocked-out is rendered causal.

Mapping genotype to phenotype for a plastic trait appears to be primarily costly, secondarily fragile. When time progresses, the cost of RNA-seq will go down and its results will be more robust.

## Conclusions

The trait types I discussed in this essay are straightforward to analyze. Sure, you will need a fair amount of money if you want to do it today, but some patience will bring these techniques within reach of every researcher. For a QTL analysis, I think obtaining the many samples needed is the step that can be automated last. For plastic traits, I hope that the decrease in cost of RNA-seq goes hand-in-hand with a consensus statistical test for finding differently expressed genes.

I am aware that I made some simplifications on the results, as if there is a one-to-one relation between gene and phenotype. In practice, there will often be a many-to-one relationship. But in my opinion, finding a gene expression network (instead of a single gene its expression) is only a trivially more complex finding, as software can help us out there.

For the other trait types, more thought needs to be put in their investigation. Luckily, that is what researchers are good at.

Richel Bilderbeek




