# Set directory
setwd('/home/bryce/Code/fantasy_predictions')
current_dir <- getwd()
DATA_FILE <- file.path(current_dir, 'lib/datasets/preseason', 'qb_preseason_data.csv')
BASIC_MODEL <- file.path(current_dir, 'lib/r_models/preseason', 'qb_preseason_basic.model')
ADV_MODEL <- file.path(current_dir, 'lib/r_models/preseason', 'qb_preseason_adv.model')

mydata <- read.csv(file=DATA_FILE, header=TRUE)

## 80% of the sample size
smp_size <- floor(0.80 * nrow(mydata))

## set the seed to make your partition reproductible
set.seed(123)

## split the data into train and test
train_ind <- sample(seq_len(nrow(mydata)), size = smp_size)
data_train <- mydata[train_ind, ]
data_test <- mydata[-train_ind, ]

## validate number of rows
nrow(data_train)
nrow(data_test)

#-------------------------------------------------------------------------
# 1) Build a basic model, to understand baseline predictions
#-------------------------------------------------------------------------
# create a linear model using the training partition
basic_lm_model <- lm(target_points ~ points, data_train)

# save the model to disk
save(basic_lm_model, file=BASIC_MODEL)

# load the model back from disk (prior variable name is restored)
load(BASIC_MODEL)

# score the test data and plot pred vs. obs 
plot(data.frame('Predicted'=predict(basic_lm_model, data_test), 'Observed'=data_test$target_points))
text(predict(basic_lm_model, data_test), data_test$target_points, labels=data_test$player_name, cex= 0.7)

# look at a summary of the model fit
summary(basic_lm_model)

# Residual standard error: 5.797 on 142 degrees of freedom
#  (249 observations deleted due to missingness)
# Multiple R-squared:  0.2837,  Adjusted R-squared:  0.2787 
# F-statistic: 56.25 on 1 and 142 DF,  p-value: 6.337e-12

# score the test data and append it as a new column (for later use)
new_data <- cbind(data_test, 'predicted_target_points_basic'=predict(basic_lm_model, data_test))

#-------------------------------------------------------------------------
# 1) Build a more advanced model, to understand baseline predictions
#-------------------------------------------------------------------------
# create a linear model using the training partition
# adv_lm_model <- lm(target_points ~ datapoints + points + preseason_rank + passing_attempts + passing_completions + passing_yards + passing_touchdowns + passing_interceptions + rushing_attempts + rushing_yards + rushing_touchdowns + fumble_fumbles + fumble_touchdowns, data_train)

adv_lm_model <- lm(target_points ~ datapoints + points + preseason_rank + passing_attempts + passing_touchdowns + passing_interceptions + rushing_yards + rushing_touchdowns, data_train)


# save the model to disk
save(adv_lm_model, file=ADV_MODEL)

# load the model back from disk (prior variable name is restored)
load(ADV_MODEL)

# score the test data and plot pred vs. obs 
plot(data.frame('Predicted'=predict(adv_lm_model, data_test), 'Observed'=data_test$target_points))
text(predict(adv_lm_model, data_test), data_test$target_points, labels=data_test$player_name, cex= 0.7)

# look at a summary of the model fit
summary(adv_lm_model)

# Residual standard error: 5.457 on 131 degrees of freedom
#  (249 observations deleted due to missingness)
# Multiple R-squared:  0.4145,  Adjusted R-squared:  0.3609 
# F-statistic: 7.729 on 12 and 131 DF,  p-value: 1.015e-10


# score the test data and append it as a new column (for later use)
new_data <- cbind(data_test, 'predicted_target_points_adv'=predict(adv_lm_model, data_test))  
