# txmBioinfoToolkit

Some useful R functions for bioinformatics study.

## Installation
```
devtools::install_github("Telogen/txmBioinfoToolkit")
```

## Update history

### 20220706

- [`ggplot2_memo.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/ggplot2_memo.R): ggplot2 functions memo. (package 'ggplot2' required)
  - `myplot_addline`: Add vertical, horizontal, or oblique line.
  - `myplot_text`: Add texts.
  - `myplot_density`: Density plot.
  - `myplot_scatter_with_density`: Scatter plot with density plot of x and y axis.

### 20220705

- [`top_n()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/top_n.R): Get top n elements.

### 20220704

- [`mybinarize()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/mybinarize.R): Binarize matrix. (package 'methods' required)
- [`mytfidf()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/mytfidf.R): TF-IDF. (package 'Matrix' required)

### 20220629

- [`myknn()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/myknn.R): Several K Nearest Neighbors (KNN) methods. (package 'Seurat' required)
- [`myRF()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/myRF.R): Random forest code memo. (package 'randomForest' required)


### 20220626

- [`mykmeans()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/mykmeans.R): Perform kmeans with multiple 'k's and automatically select the best k with the maximum silhouette. (package 'cluster' required)
- [`get_adjacency_mat()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/get_adjacency_mat.R): Get adjacency matrix from a sample-feature matrix. (package 'Seurat' required)



## Contact
ljtian20@fudan.edu.cn


