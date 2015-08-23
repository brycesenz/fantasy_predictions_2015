# Set directory

build_and_plot_lm <- function(data_name, model_name) {
  current_dir <- getwd()
  DATA_FILE <- file.path(current_dir, 'lib/datasets', data_name)
  MODEL_FILE <- file.path(current_dir, 'lib/r_models', model_name)

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
  ## split the data into train and test

  # create a linear model using the training partition
  gm_pct_model <- lm(target_points ~ datapoints + points + passing_attempts + passing_completions + passing_yards + passing_touchdowns + passing_interceptions + passing_two_points + rushing_attempts + rushing_yards + rushing_touchdowns + rushing_two_points + receiving_receptions + receiving_yards + receiving_touchdowns + receiving_two_points + fumble_fumbles + fumble_touchdowns, data_train)

  # save the model to disk
  save(gm_pct_model, file=MODEL_FILE)

  # load the model back from disk (prior variable name is restored)
  load(MODEL_FILE)

  # score the test data and plot pred vs. obs 
  plot(data.frame('Predicted'=predict(gm_pct_model, data_test), 'Observed'=data_test$target_points))
  text(predict(gm_pct_model, data_test), data_test$target_points, labels=data_test$player_name, cex= 0.7)

  # score the test data and append it as a new column (for later use)
  new_data <- cbind(data_test, 'predicted_target_points'=predict(gm_pct_model, data_test))  
}

setwd('/home/bryce/Code/fantasy_predictions')
build_and_plot_lm('qb_preseason_data.csv', 'qb_preseason.model')
build_and_plot_lm('rb_preseason_data.csv', 'rb_preseason.model')
build_and_plot_lm('wr_preseason_data.csv', 'wr_preseason.model')
build_and_plot_lm('te_preseason_data.csv', 'te_preseason.model')
build_and_plot_lm('k_preseason_data.csv', 'k_preseason.model')
build_and_plot_lm('dst_preseason_data.csv', 'dst_preseason.model')

