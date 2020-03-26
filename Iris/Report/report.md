Iris Dataset
================
Gibril

  - [Introduction](#introduction)
  - [Dataset](#dataset)
  - [Training Methods](#training-methods)
      - [Linear Discriminant Analysis](#linear-discriminant-analysis)
      - [k-Nearest Neighbour](#k-nearest-neighbour)
          - [Performance on test data](#performance-on-test-data)
      - [Gaussian Naive Bayes](#gaussian-naive-bayes)
          - [Performance on test set](#performance-on-test-set)
      - [Decision Tree](#decision-tree)
  - [Results](#results)
  - [Summary](#summary)

# Introduction

Fisher’s Iris dataset is famous for testing different classification
algorithms. It contains measurements (in cm) of sepal length and width
and petal length and width, respectively, for 50 flowers of the 3 Iris
species (setosa, versicolor, and virginica).

The aim of this project is to use various supervised learning techniques
to classify the species of a given Iris flower. We are purely interested
in the accuracy of the methods used given that the classes are balanced.

# Dataset

The dataset is freely available on the [UCI Machine Learning
Repository](http://archive.ics.uci.edu/ml/datasets/Iris). It includes 50
samples of each of the three species and some measured properties about
each flower. There are no missing observations and it is in the correct
format. As will be seen the graph below, one flower species can be
linearly separated from the other two whereas the other two are not
linearly separable from each other.

The variables in the datasets are:

  - Id
  - SepalLengthCm
  - SepalWidthCm
  - PetalLengthCm
  - PetalWidthCm
  - Species
      - Iris-setosa
      - Iris-versicolor
      - Iris-virginica

The graph below show the distributions and pairwise relationships of the
continuous variables in the dataset.
![](https://github.com/lirbig97/SProjects/blob/master/Iris/images/exploratory-1.jpeg)<!-- -->

From the graph, we see that within each variable, the classes are
approximately normally distributed. For Petal length and Petal width,
the setosa species is completely separable from the other two and
versicolor and virginica have very little overlap. This property is
masked in the scatterplots involving the Sepal width variable, making
it’s use in our models problematic for correctly classifying
versicolor and virginica. Since one of the classes (setosa), is well
separated and each class is approximately normally distributed within
the variables, the use of algorithms that assume normality will perform
well on this dataset.

And finally, a correlation matrix of the variables in the dataset (excl.
Id). The new variable `SpecNum` is the coded version of the `Species`
variable.

|               | SepalLengthCm | SepalWidthCm | PetalLengthCm | PetalWidthCm | SpecNum |
| ------------- | ------------: | -----------: | ------------: | -----------: | ------: |
| SepalLengthCm |         1.000 |      \-0.109 |         0.872 |        0.818 |   0.783 |
| SepalWidthCm  |       \-0.109 |        1.000 |       \-0.421 |      \-0.357 | \-0.419 |
| PetalLengthCm |         0.872 |      \-0.421 |         1.000 |        0.963 |   0.949 |
| PetalWidthCm  |         0.818 |      \-0.357 |         0.963 |        1.000 |   0.956 |
| SpecNum       |         0.783 |      \-0.419 |         0.949 |        0.956 |   1.000 |

The table shows that `Species` is highly correlated to `SepalLengthCm`,
`PetalLengthCm` and `PetalWidthCm`. Also, all variables except
`SepalWidthCm` are highly correlated with each other. From the above
scatterplot matrix, we see that these variables can be used to classify
`Species` with minimal misclassification and so will be prioritised in
variable selection.

# Training Methods

Before training any classifier on this dataset, we use 80% of the data
as training set and the remaining 20% as a validation set. The
performance metric used will be accuracy.

``` r
  library(caret) # wrapper functions for training methods
  set.seed(26032020)

  train.index <- createDataPartition(iris_data$Species, p = 0.8, list = FALSE)
  train.df  <- iris_data[train.index, ]
  test.df  <- iris_data[-train.index, ]
  
  ctrl <- trainControl(method  = 'repeatedcv',
                       repeats = 2)
```

## Linear Discriminant Analysis

## k-Nearest Neighbour

K-NN utilizes distance calculations so preprocessing our training data
by scaling and centering will improve training speed and prediction
accuracy.

``` r
  knn.fit1 <- train(Species ~.,
                    data         = train.df[, -c(1,7)], # dropping Id and SpecNum 
                    method       = 'knn',
                    preProcess   = c('center', 'scale'),
                    tuneLength   = 7)
  
  knn.fit1
```

    k-Nearest Neighbors 
    
    120 samples
      4 predictor
      3 classes: 'Iris-setosa', 'Iris-versicolor', 'Iris-virginica' 
    
    Pre-processing: centered (4), scaled (4) 
    Resampling: Bootstrapped (25 reps) 
    Summary of sample sizes: 120, 120, 120, 120, 120, 120, ... 
    Resampling results across tuning parameters:
    
      k   Accuracy   Kappa    
       5  0.9103664  0.8640283
       7  0.9211731  0.8805700
       9  0.9323956  0.8974051
      11  0.9359207  0.9029332
      13  0.9328731  0.8984102
      15  0.9300223  0.8941027
      17  0.9270278  0.8897719
    
    Accuracy was used to select the optimal model using the largest value.
    The final value used for the model was k = 11.

``` r
  plot(varImp(knn.fit1))
```

![](https://github.com/lirbig97/SProjects/blob/master/Iris/images/knn1-1.jpeg)<!-- -->

From the summary of k-NN model we see that, as suspected, the SepalWidth
variable isn’t as important as the other variables as seen in the
variable importance plot. We now fit a another k-NN model without the
SepalWidth variable and examine the change in accuracy.

``` r
  knn.fit2 <- train(Species ~ SepalLengthCm + PetalLengthCm + PetalWidthCm,
                    data       = train.df[, -c(1,7)],
                    method     = 'knn',
                    preProcess = c('center', 'scale'),
                    tuneLength = 5)

  knn.fit2
```

    k-Nearest Neighbors 
    
    120 samples
      3 predictor
      3 classes: 'Iris-setosa', 'Iris-versicolor', 'Iris-virginica' 
    
    Pre-processing: centered (3), scaled (3) 
    Resampling: Bootstrapped (25 reps) 
    Summary of sample sizes: 120, 120, 120, 120, 120, 120, ... 
    Resampling results across tuning parameters:
    
      k   Accuracy   Kappa    
       5  0.9310705  0.8954223
       7  0.9375861  0.9054779
       9  0.9449541  0.9163778
      11  0.9398638  0.9087289
      13  0.9331829  0.8987416
    
    Accuracy was used to select the optimal model using the largest value.
    The final value used for the model was k = 9.

The accuracy is almost the same after removing SepalWidth from the new
model with the same number of neighbours as the first model. However,
with fewer predictors and a small change in the accuracy score, our new
model may perform better with the test set.

### Performance on test data

Evaluating model performance on the test set.

``` r
  knn1.predict <- predict(knn.fit1, test.df)
  knn2.predict <- predict(knn.fit2, test.df)
  
  confusionMatrix(knn1.predict, test.df$Species)
```

    Confusion Matrix and Statistics
    
                     Reference
    Prediction        Iris-setosa Iris-versicolor Iris-virginica
      Iris-setosa              10               0              0
      Iris-versicolor           0              10              0
      Iris-virginica            0               0             10
    
    Overall Statistics
                                         
                   Accuracy : 1          
                     95% CI : (0.8843, 1)
        No Information Rate : 0.3333     
        P-Value [Acc > NIR] : 4.857e-15  
                                         
                      Kappa : 1          
                                         
     Mcnemar's Test P-Value : NA         
    
    Statistics by Class:
    
                         Class: Iris-setosa Class: Iris-versicolor
    Sensitivity                      1.0000                 1.0000
    Specificity                      1.0000                 1.0000
    Pos Pred Value                   1.0000                 1.0000
    Neg Pred Value                   1.0000                 1.0000
    Prevalence                       0.3333                 0.3333
    Detection Rate                   0.3333                 0.3333
    Detection Prevalence             0.3333                 0.3333
    Balanced Accuracy                1.0000                 1.0000
                         Class: Iris-virginica
    Sensitivity                         1.0000
    Specificity                         1.0000
    Pos Pred Value                      1.0000
    Neg Pred Value                      1.0000
    Prevalence                          0.3333
    Detection Rate                      0.3333
    Detection Prevalence                0.3333
    Balanced Accuracy                   1.0000

``` r
  confusionMatrix(knn2.predict, test.df$Species)
```

    Confusion Matrix and Statistics
    
                     Reference
    Prediction        Iris-setosa Iris-versicolor Iris-virginica
      Iris-setosa              10               0              0
      Iris-versicolor           0              10              0
      Iris-virginica            0               0             10
    
    Overall Statistics
                                         
                   Accuracy : 1          
                     95% CI : (0.8843, 1)
        No Information Rate : 0.3333     
        P-Value [Acc > NIR] : 4.857e-15  
                                         
                      Kappa : 1          
                                         
     Mcnemar's Test P-Value : NA         
    
    Statistics by Class:
    
                         Class: Iris-setosa Class: Iris-versicolor
    Sensitivity                      1.0000                 1.0000
    Specificity                      1.0000                 1.0000
    Pos Pred Value                   1.0000                 1.0000
    Neg Pred Value                   1.0000                 1.0000
    Prevalence                       0.3333                 0.3333
    Detection Rate                   0.3333                 0.3333
    Detection Prevalence             0.3333                 0.3333
    Balanced Accuracy                1.0000                 1.0000
                         Class: Iris-virginica
    Sensitivity                         1.0000
    Specificity                         1.0000
    Pos Pred Value                      1.0000
    Neg Pred Value                      1.0000
    Prevalence                          0.3333
    Detection Rate                      0.3333
    Detection Prevalence                0.3333
    Balanced Accuracy                   1.0000

Since both models perform equally well on the test set, we choose the
second model which is more parsimonious. Both models perfectly classify
all Iris species.

## Gaussian Naive Bayes

We now fit a Gaussian Naive Bayes model without any preprocessing as it
will have very little impact on the resulting model.

``` r
  gaussianNB <- train(Species ~ SepalLengthCm + PetalLengthCm + PetalWidthCm,
                      data     = train.df,
                      method   = 'naive_bayes',
                      tuneGrid = data.frame(usekernel  = F, # setting to F assumes
                                                            # normal dist.
                                            laplace    = 0,
                                            adjust     = 1))
  gaussianNB
```

    Naive Bayes 
    
    120 samples
      3 predictor
      3 classes: 'Iris-setosa', 'Iris-versicolor', 'Iris-virginica' 
    
    No pre-processing
    Resampling: Bootstrapped (25 reps) 
    Summary of sample sizes: 120, 120, 120, 120, 120, 120, ... 
    Resampling results:
    
      Accuracy   Kappa    
      0.9447984  0.9159826
    
    Tuning parameter 'laplace' was held constant at a value of 0
    
    Tuning parameter 'usekernel' was held constant at a value of FALSE
    
    Tuning parameter 'adjust' was held constant at a value of 1

Training accuracy for the Gaussian Naive Bayes is comparable to the
accuracy score obtained using k-NN.

### Performance on test set

``` r
  gaussianNB.predict <- predict(gaussianNB, test.df)

  confusionMatrix(gaussianNB.predict, test.df$Species)
```

    Confusion Matrix and Statistics
    
                     Reference
    Prediction        Iris-setosa Iris-versicolor Iris-virginica
      Iris-setosa              10               0              0
      Iris-versicolor           0              10              0
      Iris-virginica            0               0             10
    
    Overall Statistics
                                         
                   Accuracy : 1          
                     95% CI : (0.8843, 1)
        No Information Rate : 0.3333     
        P-Value [Acc > NIR] : 4.857e-15  
                                         
                      Kappa : 1          
                                         
     Mcnemar's Test P-Value : NA         
    
    Statistics by Class:
    
                         Class: Iris-setosa Class: Iris-versicolor
    Sensitivity                      1.0000                 1.0000
    Specificity                      1.0000                 1.0000
    Pos Pred Value                   1.0000                 1.0000
    Neg Pred Value                   1.0000                 1.0000
    Prevalence                       0.3333                 0.3333
    Detection Rate                   0.3333                 0.3333
    Detection Prevalence             0.3333                 0.3333
    Balanced Accuracy                1.0000                 1.0000
                         Class: Iris-virginica
    Sensitivity                         1.0000
    Specificity                         1.0000
    Pos Pred Value                      1.0000
    Neg Pred Value                      1.0000
    Prevalence                          0.3333
    Detection Rate                      0.3333
    Detection Prevalence                0.3333
    Balanced Accuracy                   1.0000

The Naive Bayes model performs very well on the validation set. It
correctly classifies all iris species.

## Decision Tree

# Results

# Summary
