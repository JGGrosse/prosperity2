path_prices_1 <-"prices_round_4_day_1.csv"
path_prices_2 <-"prices_round_4_day_2.csv"
path_prices_3 <-"prices_round_4_day_3.csv"

prices_1 <-read.csv(path_prices_1, sep=";")
prices_2 <-read.csv(path_prices_2, sep=";")
prices_3 <-read.csv(path_prices_3, sep=";")


prices_2$timestamp <- prices_1$timestamp + 1000000
prices_3$timestamp <- prices_2$timestamp + 2000000

#bind into 1 df 
prices <- rbind(prices_1, prices_2, prices_3)

library(dplyr)

prices <- prices %>%
  mutate(
    cardinal_mid = case_when(
      !is.na(bid_price_3) & !is.na(ask_price_3) ~ (bid_price_3 + ask_price_3) / 2,
      !is.na(bid_price_2) & !is.na(ask_price_3) ~ (bid_price_2 + ask_price_3) / 2,
      !is.na(bid_price_1) & !is.na(ask_price_3) ~ (bid_price_1 + ask_price_3) / 2,
      !is.na(bid_price_3) & !is.na(ask_price_2) ~ (bid_price_3 + ask_price_2) / 2,
      !is.na(bid_price_2) & !is.na(ask_price_2) ~ (bid_price_2 + ask_price_2) / 2,
      !is.na(bid_price_1) & !is.na(ask_price_2) ~ (bid_price_1 + ask_price_2) / 2,
      !is.na(bid_price_3) & !is.na(ask_price_1) ~ (bid_price_3 + ask_price_1) / 2,
      !is.na(bid_price_2) & !is.na(ask_price_1) ~ (bid_price_2 + ask_price_1) / 2,
      !is.na(bid_price_1) & !is.na(ask_price_1) ~ (bid_price_1 + ask_price_1) / 2,
      TRUE ~ NA_real_
    )
  )


# Filtering data for each product
coconut <- prices %>% filter(product == "COCONUT")
coupon <- prices %>% filter(product == "COCONUT_COUPON")
sd(coconut$mid_price*0.0635 -coupon$mid_price)

# Fitting polynomial regression
model <- lm(coconut$mid_price ~ poly(coupon$mid_price, 5, raw = TRUE))

# Displaying the model summary to evaluate
summary(model)






library(ggplot2)


plot_data <- left_join(combined, gift_basket, by = "timestamp", suffix = c("_combined", "_gift_basket"))

# Calculate differences
plot_data <- plot_data %>%
  mutate(
    diff_mid_price = gift_basket$mid_price - combined_mid_price,
    diff_cardinal_mid = gift_basket$cardinal_mid - combined_cardinal_mid,
    std_diff_mid_price = (diff_mid_price - mean(diff_mid_price, na.rm = TRUE)) / sd(diff_mid_price, na.rm = TRUE),
    std_diff_cardinal_mid = (diff_cardinal_mid - mean(diff_cardinal_mid, na.rm = TRUE)) / sd(diff_cardinal_mid, na.rm = TRUE),
    ratio_mid_price = gift_basket$mid_price / combined_mid_price,
    ratio_cardinal_mid = gift_basket$cardinal_mid / combined_cardinal_mid
  )

# Filter the data for specified timestamp range
plot_data_filtered <- plot_data %>%
  filter(timestamp >= 200000, timestamp <= 210000)

# Plot Normal Differences for filtered data
normal_diff_plot<-ggplot(plot_data_filtered, aes(x = timestamp)) +
  geom_line(aes(y = diff_mid_price, colour = "Mid Price")) +
  geom_line(aes(y = diff_cardinal_mid, colour = "Cardinal Mid")) +
  labs(title = "Normal Differences Over Time (Filtered 20000-21000)",
       x = "Timestamp",
       y = "Price Difference") +
  scale_color_manual(values = c("Mid Price" = "blue", "Cardinal Mid" = "red")) +
  theme_minimal()

# Plot Standardized Differences for filtered data
standardized_diff_plot <-ggplot(plot_data_filtered, aes(x = timestamp)) +
  geom_line(aes(y = std_diff_mid_price, colour = "Mid Price")) +
  geom_line(aes(y = std_diff_cardinal_mid, colour = "Cardinal Mid")) +
  labs(title = "Standardized Differences Over Time (Filtered 20000-21000)",
       x = "Timestamp",
       y = "Standardized Price Difference") +
  scale_color_manual(values = c("Mid Price" = "blue", "Cardinal Mid" = "red")) +
  theme_minimal()


# Plot Ratio
ratio_plot <-ggplot(plot_data_filtered, aes(x = timestamp)) +
  geom_line(aes(y = ratio_mid_price, colour = "Mid Price")) +
  geom_line(aes(y = ratio_cardinal_mid, colour = "Cardinal Mid")) +
  labs(title = "Ratio Over Time (Filtered 20000-21000)",
       x = "Timestamp",
       y = "Ratio") +
  scale_color_manual(values = c("Mid Price" = "blue", "Cardinal Mid" = "red")) +
  theme_minimal()


normal_diff_plot
standardized_diff_plot
ratio_plot

# Save the plots
ggsave("normal_differences_plot.jpeg", normal_diff_plot, width = 12, height = 8, dpi = 300)
ggsave("standardized_differences_plot.jpeg", standardized_diff_plot, width = 10, height = 6, dpi = 300)