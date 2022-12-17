# txmBioinfoToolkit

Some useful R functions for bioinformatics study.

## Installation

```
devtools::install_github("Telogen/txmBioinfoToolkit")
```

## Update history

### 20221217

- [`my_plot_jupyter_settings.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/my_plot_jupyter_settings.R): 


### 20220727

- [`get_cutoff.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/get_cutoff.R): Get cutoff based on the best F1 score. (package 'MLmetrics, ggplot2' required)


### 20220722

- [`mysparseMatrix.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/mysparseMatrix.R): Memo of creating a sparseMatrix.

### 20220712

- [`get_rank.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/get_rank.R): Get ranks of a vector with names.
- [`get_quantile()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/get_rank.R): Get quantile of a number in a vector.

### 20220709

- [`myplot_ComplexHeatmap.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/myplot_ComplexHeatmap.R): Memo of ComplexHeatmap functions. (package 'ComplexHeatmap' required)

### 20220706

- [`myinstall.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/myinstall.R): Memo of installing R packages. 
  - `myinstall_with_C99`: Install R packages with C99 standard. (package 'withr' required)
  - `myinstall_version`: Install R package with specific version. (package 'remotes' required)
  - `myinstall_local`: Install local R package. (package 'devtools' required)

- [`myplot_ggplot.R`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/myplot_ggplot2.R): Memo of ggplot2 functions. (package 'ggplot2' required)
  - `myplot_addline`: Add vertical, horizontal, or oblique line.
  - `myplot_text`: Add texts.
  - `myplot_density`: Density plot.
  - `myplot_scatter_with_density`: Scatter plot with density plot of x and y axis.
  - `myplot_bar`: Barplot.

### 20220705

- [`top_n()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/top_n.R): Get top n elements.

### 20220704

- [`mybinarize()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/mybinarize.R): Binarize matrix. (package 'methods' required)
- [`mytfidf()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/mytfidf.R): TF-IDF. (package 'Matrix' required)

### 20220629

- [`myknn()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/myknn.R): Several K Nearest Neighbors (KNN) methods. (package 'Seurat' required)
- [`myRF()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/myRF.R): Memo of random forest code. (package 'randomForest' required)


### 20220626

- [`mykmeans()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/mykmeans.R): Perform kmeans with multiple 'k's and automatically select the best k with the maximum silhouette. (package 'cluster' required)
- [`get_adjacency_mat()`](https://github.com/Telogen/txmBioinfoToolkit/blob/main/R/get_adjacency_mat.R): Get adjacency matrix from a sample-feature matrix. (package 'Seurat' required)



## Contact
ljtian20@fudan.edu.cn


