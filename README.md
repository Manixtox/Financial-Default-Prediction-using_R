# Financial-Default-Prediction-using_R
INTRODUCTION

In the following work we will carry out a predictive analysis of credit defaults. In other words , we will try to predict which clients would be more susceptible to defaulting on their credit, based on information such as employment status, their bank account balance and the annual salary they receive. We will mainly use two models. One of decision trees and another of Discriminant Analysis. We will use the models after having done an EDA Exploratory Data Analysis.

EDA
We will define the EDA as the initial process of any Data Science project, the Exploration process. Classical statistics focused almost exclusively on inference, which is defined as a set of processes, sometimes very complex, designed to draw conclusions about large populations based on small samples. (Bruce, et al., 2020). Initially this process, conceived by John W. Tukey , consisted of presenting boxplots, scatterplots and a summary of important statistics such as the mean, median, quantiles , etc. (Tukey, 1977). With the recent availability of high computational power the EDA has also evolved. The drivers for such advances were the rapid development of new technology and access to more variety and greater amounts of data. (Bruce, et al, 2020)

Decision Trees
Decision trees, also called classification trees or regression trees, are a popular and effective method of classification. They were initially developed by Leo Breiman and others in 1984. Decision trees and their descendants Random Forests and Boosted trees are the basis of models widely used in Data Science. We can think of decision trees as a group of if-then-else rules , which are very easy to implement. (Bruce, et al, 2020). In contrast to linear and logistic regression, decision trees have the ability to find hidden patterns in complex data interactions.

Discriminant Analysis
Discriminant analysis is the oldest statistical classifier; It was introduced by RA Fisher in 1936 in an article published in the Annals of Eugenics. journal . Although discriminant analysis involves many techniques, the most widely used is Linear Discriminant Analysis LDA. Today it is not used as much, due to the creation of more sophisticated techniques such as tree models and logistic regression. However, the LDA is very useful in certain cases and is linked to other more used methods such as Principal Components. To understand this method it is necessary to understand the covariance matrix.






THE DATASET
For our analysis we will work with the dataset Default_Fin , pulled from the Kaggle platform .
i.	Dimensions:
•	10000 records.
•	Index, mark of employee or unemployed, bank balance, client salary, mark of delinquency or no delinquency.
variables
•	Index : identifier number
•	Employed : Boolean flag, where:
1 = employee
0 = unemployed.
•	Bank balance: Customer's bank balance.
•	annual salary : Annual salary of the client.
•	Defaulted : boolean flag, where:
1 = in arrears
0 = no default
It is important to note that the label of our dataset , also known as the dependent variable, is not balanced, that is, there are many more observations of cases without default than of cases with default. A process for dealing with this will be described in the Procedure and Results section.

METHODOLOGY
We will use all the statistical techniques included in the R language for the EDA processes and the Decision Tree and LDA modeling, Linear Discriminant Analysis. We will interpret the results after each line of code we use. We will run tests to determine which is the best model for our dataset for our conclusion.
