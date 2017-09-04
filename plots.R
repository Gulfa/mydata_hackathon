library(ggplot2)
library(GGally)
library(polycor)
library(corrplot)

setwd("~/R-projects/MyData2017")
load("blurred.Rdata")

# calculate mean of systolic blood pressure
systolic_columns <- c("ft17_tt1_sys1","ft17_tt1_sys2","ft17_tt1_sys3")
diastolic_columns <- c("ft17_tt1_dias1","ft17_tt1_dias2","ft17_tt1_dias3")
cog_word_columns <- c("ft17_tt3_7_sanat_oikein_1","ft17_tt3_9_sanat_oikein_2","ft17_tt3_11_sanat_oikein_3")

d.new <- data.frame(sys_avg = rowMeans(d.mi[systolic_columns]))
d.new$dias_avg <- rowMeans(d.mi[diastolic_columns])
d.new$cog_words <- rowMeans(d.mi[cog_word_columns])

d.processed <- cbind(d.mi, d.new)
d.processed[systolic_columns] <- NULL
d.processed[diastolic_columns] <- NULL
d.processed[cog_word_columns] <- NULL
d.processed["mi"] <- NULL

corr_matrix <- hetcor(d.processed)

corr_matrix.plot <- corrplot(corr_matrix$correlations, "ellipse")
ggsave(filename="correlation_matrix_plot.jpg", plot=corr_matrix.plot)

# scatter.plot <- ggpairs(d.processed)
ggsave(filename="scatter_plot.jpg", plot=scatter.plot)

