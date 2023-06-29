# TRABAJO FINAL
#Importamos el dataset Default_Fin
datos_cred <- read.csv(file = 'Default_Fin.csv',header= TRUE)
str(datos_cred)

head(datos_cred, 10)

#Chequeamos el balance de Defaulted
prop.table(table(datos_cred$Defaulted))

#Nos deshacemos de la columna Index
datos_cred <- subset( datos_cred, select = -Index )
head(datos_cred, 10)

#Balanceamos nuestra data 

install.packages("ROSE")
library(ROSE)
data_cred_bal <- ovun.sample(Defaulted. ~ ., data = datos_cred, 
                             method = "under", N = 666, seed = 1)$data
table(data_cred_bal$Defaulted.)     

#Selecionamos las mejores variables
library(leaps)
Best_Subset <-
  regsubsets(Defaulted.~.,
             data =data_cred_bal,
             nbest = 1,      # 1 best model for each number of predictors
             nvmax = NULL,    # NULL for no limit on number of variables
             force.in = NULL, force.out = NULL,
             method = "exhaustive")
summary_best_subset <- summary(Best_Subset)
as.data.frame(summary_best_subset$outmat)

which.max(summary_best_subset$adjr2)
summary_best_subset$which[3,]

# Scatter Plots y 3d
library(lattice)

splom(data_cred_bal)

library(scatterplot3d)
s3d <- with(data_cred_bal, scatterplot3d(Annual.Salary, Bank.Balance, Defaulted., pch = 16, 
                                 highlight.3d = TRUE, angle = 60))

# MATRIZ DE COVARIANZA

cov(data_cred_bal)

#Matriz de Correlaciones
library(ggplot2)
install.packages("ggcorrplot")
library(ggcorrplot)

corrmat <- round(cor(data_cred_bal),2)
corrmat

ggcorrplot(corrmat)

#sumariZACION

fit_mora <- lm(Defaulted. ~ Employed + Bank.Balance + Annual.Salary, data=data_cred_bal )
head(model.matrix(fit_mora))
summary(fit_mora)

# Analsis de REsiduos
plot(fit_mora, which=1, col=c("blue")) # Residuals vs Fitted Plot

par(mfrow=c(2,2))                   # dividing the plot window into four frames
plot(fit_mora)                              # Residual plots and diagnostics
par(op) 

#Test de Normalidad
# f) TEst de noramlidad
library(nortest)
res<-fit_mora$resid                        # saving the residuals from the regression as "res"
ad.test(res)                           # Anderson-Darling test of normality
lillie.test(res)                       # Kolomogorov-Smirnov test of normality
sf.test(res)                           # Shapiro-Francia test of normality
shapiro.test(res)                      # Shapiro test of normalty
pearson.test(res)

#Test de Homcedasticidad
library(lmtest)
bptest(fit_mora)

#Anova
ava1 <- aov(fit_mora)
summary(ava1)

# Division de la data
set.seed(1234)
ind<-sample(2,nrow(data_cred_bal), replace=T,prob=c(0.7,0.3))
trainData<-data_cred_bal[ind==1,]
testData<-data_cred_bal[ind==2,]
head(data_cred_bal,10)
head(trainData,5)
#Arboles de Decission
library(party)
myFormula <- Defaulted.~ + Employed + Bank.Balance + Annual.Salary
heart_ctree<-ctree(myFormula,data=trainData)
table(predict(heart_ctree),trainData$Defaulted.)
plot(heart_ctree)

#Evaluacion 
library(rpart)
library(readr)
library(caTools)
library(dplyr)
library(party)
install.packages(("partykit"))
library(partykit)
install.packages(("rpart.plot"))
library(rpart.plot)
fit <- rpart(myFormula, data = trainData, method = 'class')
rpart.plot(fit, extra = 106)

prediccion <-predict(fit, testData, type = 'class')
table_mat <- table(testData$Defaulted., prediccion)
table_mat
accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
accuracy_Test

# ANALISIS DISCRMINANTE
library(MASS)

fit_lda <- lda(Defaulted.~ Employed+Bank.Balance+Annual.Salary, data=trainData)

fit_lda

predict_lda <- predict(object = fit_lda, newdata = testData[, -4])
table_mat2 <- table(testData$Defaulted., predict_lda$class, dnn = c("Clase real", "Clase predicha"))
table_mat2

accuracy_Test <- sum(diag(table_mat2)) / sum(table_mat2)
accuracy_Test

# Con crossvalidation
fit_lda2 <- lda(Defaulted.~ Employed+Bank.Balance+Annual.Salary, data=trainData, CV=TRUE)

# K-MEANS
library()
km1 = kmeans(trainData[,-4],  2)
plot(trainData, col = km1$cluster)
points(km1$centers, col = 1:5, pch = 8)

install.packages("klaR")
library(klaR)
# Visualizacion lda
partimat(Defaulted.~ Employed+Bank.Balance+Annual.Salary,
         data = data_cred_bal, method = "lda", prec = 200,
         image.colors = c("darkgoldenrod1", "snow2", "skyblue2"),
         col.mean = "firebrick")

# testeo de REgresion Lineal
fit_reg <- lm(myFormula, data=trainData)
predict_reg <- predict(object = fit_reg, newdata = testData[, -4])

summary(fit_reg)
traindat_mse <- mean((fit_reg$fitted.values - trainData$Defaulted.)^2)
traindat_mse

test_mse <- mean((predict_reg - testData$Defaulted.)^2)
test_mse

actuals_preds <- data.frame(cbind(actuals=testData$Defaulted., predicteds=predict_reg))
correlation_accuracy <- cor(actuals_preds) 
correlation_accuracy
