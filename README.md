# Aruba Capital
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-5-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->


In this repo we present ideas and code for the second IMC Prosperity competition, hosted in 2024. Our team, Aruba Capital, finished 22nd globally out of more then 2800 active competitors, placing us in the top 1%. In this write up we will focus on the algorithmic coding rounds (and not the manual challenges).

## Team members

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%">
        <a href="https://github.com/jaJann312">
          <img src="https://avatars.githubusercontent.com/u/49684458?v=4" width="100px;" alt="Jannik Proff"/>
          <br /><sub><b>Jannik Proff</b></sub></a>
        <br /><sub><a href="https://www.linkedin.com/in/jproff/" title="LinkedIn">🔗 LinkedIn</a></sub>
      </td>
      <td align="center" valign="top" width="14.28%">
        <a href="https://github.com/JGGrosse">
          <img src="https://avatars.githubusercontent.com/u/142249387?v=4" width="100px;" alt="Janek Große"/>
          <br /><sub><b>Janek Große</b></sub></a>
        <br /><sub><a href="https://www.linkedin.com/in/janek-grosse/" title="LinkedIn">🔗 LinkedIn</a></sub>
      </td>
      <td align="center" valign="top" width="14.28%">
        <a href="https://github.com/Luka-R-Lukacevic">
          <img src="https://avatars.githubusercontent.com/u/125273166?v=4" width="100px;" alt="Luka Lukačević"/>
          <br /><sub><b>Luka Lukačević</b></sub></a>
        <br /><sub><a href="https://www.linkedin.com/in/luka-lukačević/" title="LinkedIn">🔗 LinkedIn</a></sub>
      </td>
      <td align="center" valign="top" width="14.28%">
        <a href="https://github.com/PaulHenrik">
          <img src="https://avatars.githubusercontent.com/u/19336571?v=4" width="100px;" alt="Paul Heilmann"/>
          <br /><sub><b>Paul Heilmann</b></sub></a>
      </td>
      <td align="center" valign="top" width="14.28%">
        <a href="https://github.com/tinotil">
          <img src="https://avatars.githubusercontent.com/u/35002593?v=4" width="100px;" alt="Constantin Schott"/>
          <br /><sub><b>Constantin Schott</b></sub></a>
      </td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

## 🐚 What is prosperity?

"Prosperity is a 15-day long trading challenge happening somewhere in a near - utopian - future. You’re in control of an island in an archipelago and your goal is to bring your island to prosperity. You do so by earning as many SeaShells as possible; the main currency in the archipelago. The more SeaShells you earn, the more your island will prosper. 

During your 15 days on the island, your trading abilities will be tested through a variety of trading challenges. It’s up to you to develop a successful trading strategy. You will be working on a Python script to handle algorithmic trades on your behalf. Every round you will also be confronted with a manual trading challenge. Your success depends on both these algorithmic and manual trades." (IMC description)

There were over 2800 active teams, tasked with algorithmically trading various products, such as amethysts, starfruit, orchids, coconuts, and more, with the goal of maximizing seashells: the underlying currency of our island.

In round 1, we began trading amethysts and starfruit. With each subsequent round, additional products were introduced. Our trading algorithm was assessed at the end of each round by comparing its performance to that of bot participants in the marketplace. We could attempt to predict the bots' behavior using historical data. Our PNL from this evaluation was then compared to that of other teams.

Aside from the main focus on algorithmic trading, the competition included manual trading challenges in each round. These challenges varied significantly, but manual trading ultimately contributed only a small fraction to our overall PNL.

For more details on the algorithmic trading environment and additional context about the competition, please refer to the [Prosperity 2 Wiki](https://imc-prosperity.notion.site/Prosperity-2-Wiki-fe650c0292ae4cdb94714a3f5aa74c85).

## Organization

This repository contains all of our code–including internal tools, research notebooks, raw data and backtesting logs, and all versions of our algorithmic trader. The repository is organized by round.

<details>
<summary><h2>Tools </h2></summary>

Instead of building our tools in-house, we decided to leverage the open-source wizardry of  [Jasper van Merle](https://github.com/jmerle). His tools provided the foundation we needed, allowing us to tailor our focus on other areas of development. We utilized his two main tools: a backtester and a visualiser.

### Backtester

We realized we needed a comprehensive backtesting environment very early on. After going after that ourselves with not a lot of success, fortunately, Jasper van Merle's [backtester](https://github.com/jmerle/imc-prosperity-2-backtester) was released to take in historical data and a trading algorithm. With the historical data, it would construct all the necessary information (replicating the actual trading environment perfectly) that our trading algorithm needed, input it into our trading algorithm, and receive the orders that our algorithm would send. Then, it would match those orders to the orderbook to generate trades. After running, the backtester would create a log file in the exact same format as the Prosperity website, that the visualiser was then able to visualise.


![Backtested PNL](https://github.com/Luka-R-Lukacevic/prosperity2/blob/main/Images/Backtester%20Image.jpeg)


### Visualiser

Jasper van Merle's [visualizer](https://jmerle.github.io/imc-prosperity-2-visualizer/?/visualizer) visualiser was an immense tool for us that provided a powerful and flexible way to analyze our trading data, helping us to identify and rectify issues, and ultimately improve our trading strategies. 


![Visualiser in Action](https://github.com/Luka-R-Lukacevic/prosperity2/blob/main/Images/Visualiser%20Image.png)


</details>
<details>
<summary><h2>Round 1️⃣</h2></summary>

In round 1, we had access to two symbols to trade: amethysts and starfruit. 

### Amethysts
Amethysts were fairly simple, as the fair price clearly never deviated from 10,000. As such, we wrote our algorithm to trade against bids above 10,000 and asks below 10,000. Besides taking orders, our algorithm also would market-make, placing bids and asks below and above 10,000, respectively.

### Starfruit

Starfruits were an asset with an orderbook limit of 20 (as were amethysts). Here the price fluctuated much more though, usually hundreds 

However, using the mid price–even in averaging over it–didn't seem to be the best, as the mid price was noisy from market participants continually putting orders past mid (orders that we thought were good to fair and therefore ones that we wanted to trade against). Looking at the orderbook, we found out that, at all times, there was a market making bot quoting relatively large sizes on both sides, at prices that were unaffected by smaller participants[^2]. Using this market maker's mid price as a fair turned out to be much less noisy and generated more pnl in backtests. 

<img width="744" alt="Screenshot 2024-05-20 at 11 54 46 PM" src="https://github.com/ericcccsliu/imc-prosperity-2/assets/62641231/26d2f65c-2a5a-4252-8094-34a35a280020">
<p align="center">
  <em>histograms of volumes on the first and second level of the bid side</em>
</p>

Surprisingly, when we tested our algorithm on the website, we figured out that the website was marking our pnl to the market maker's mid instead of the actual mid price. We were able to verify this by backtesting a trading algorithm that bought 1 starfruit in the first timestamp and simply held it to the end–our pnl graph marked to market maker mid in our own backtesting environment exactly replicated the pnl graph on the website. This boosted our confidence in using the market maker mid as fair, as we realized that we'd just captured the true internal fair of the game. Besides this, some research on the fair price showed that starfruit was very slightly mean reverting[^3], and the rest was very similar to amethysts, where we took orders and quoted orders with a certain edge, optimizing all parameters in our internal backtester with a grid search.

After round 1, our team was ranked #3 in the world overall. We had an algo trading profit of 34,498 seashells–just 86 seashells behind first place.

</details>

<details>
<summary><h2>Round 2️⃣</h2></summary>
  
### Orchids
Orchids were introduced in round 2, as well as a bunch of data on sunlight, humidity, import/export tariffs, and shipping costs. The premise was that orchids were grown on a separate island[^4], and had to be imported–subject to import tariffs and shipping costs, and that they would degrade with suboptimal levels of sunlight and humidity. We were able to trade orchids both in a market on our own island, as well as through importing them from the South archipelago. With this, we had two initial approaches. The obvious approach, to us, was to look for alpha in all the data available, investigating if the price of orchids could be predicted using sunlight, humidity, etc. The other approach involved understanding exactly how the mechanisms for trading orchids worked, as the documentation was fairly unclear. Thus, we split up: Eric looked for alpha in the historical data while Jerry worked on understanding the actual trading environment.

Finding tradable correlations in the historical data was tougher than we initially thought. Some things that we tried were[^5]: 
- Just trying to find correlations to orchids returns from returns in sunlight, humidity, tarriffs, costs. Initial results from this seemed interesting–but the correlations we found here were likely spurious.
- Linear regressions from returns in sunlight, humidity, etc., to returns in orchids. We tried varying timeframes–first predicting orchids returns in the same timeframe as the returns in the predictors, and then predicting using lagged returns–building models that predicted future orchids returns over some timeframe using past returns in each of the predictors.
- Feature engineering with the various features given and performing the previous two steps again with the newly constructed features

All of these failed to leave us with a convincing model, leading us to believe that the data given was a bit of a distraction[^6]. 

Meanwhile, Jerry was having much better luck. In experimenting around with the trading environment, we realized that there was a massive taker in the local orchids market. Sell orders–and just sell orders–just a bit above the best bids would be instantly taken for full size. This, combined with low implied ask prices from the foreign market, meant that we could simply put large sell orders locally and simultaneously buy from the south archipelago for an arbitrage. As a first pass, our algorithm running this strategy made 60k seashells over over a fifth of a day. From here, some quick further optimization brought our website test pnl to just over 100k seashells, giving us a projected profit of 500k over a full day. 

While we figured this out independently, someone in the discord leaked this same strategy–which was quite unfortunate from our standpoint, as we knew that many teams would be able to implement the exact same thing and get the same pnl as us. With some noise from slight differences in implementation, we knew that we very well could end up dropping many places, if other teams with the same strategy simply got a bit luckier. So, we spent lots of time desperately searching for any further optimization on the arbitrage. We tested out different prices for sell orders in the local market, and found that using a price of `foreign ask price - 2` worked best. However, with this fixed level for our sell orders, we worried about changes in the market preventing this level from being consistently filled. As such, we came up with an "adaptive edge" algorithm, which looked at how much volume we got at each iteration (with the maximum, nominal volume being 100 lots). If the average volume we received was below some threshold, we'd start moving our sell order level around, automatically searching for a new level to maximize profits. 

Even with these optimizations, we still were beat out by the surge of teams who also found the arbitrage. We dropped all the way to 17th place, with a profit of 573,000 seashells from algo trading. We were within 20k of the second place team, and 100k away from the first place team, Puerto Vallarta, who seemed to have figured something out this round that no other teams could find. 

</details>
<details>
<summary><h2>Round 3️⃣</h2></summary>
Gift baskets :basket:, chocolate 🍫, roses 🌹, and strawberries 🍓 were introduced in round 3, where a gift basket consisted of 4 chocolate bars, 6 strawberries, and a single rose. This round, we mainly traded spreads, which we defined as `basket - synthetic`, with `synthetic` being the sum of the price of all products in a basket.

### Spread
In this round, we quickly converged on two hypotheses. The first hypothesis was that the synthetic would be leading baskets or vice versa, where changes in the price of one would lead to later changes in the price of the other.  Our second hypothesis was that the spread might simply just be mean reverting. We observed that the price of the spread–which theoretically should be 0–hovered around some fixed value, which we could trade around. We looked into leading/lagging relationships between the synthetic and the basket, but this wasn't very fruitful, so we then investigated the spread price. 

![newplot (1)](https://github.com/ericcccsliu/imc-prosperity-2/assets/62641231/6e56f911-8f7c-484c-8dab-32a1603ad2de)

Looking at the spread, we found that the price oscillated around ~370 across all three days of our historical data. Thus, we could profitably trade a mean-reverting strategy, buying spreads (going long baskets and short synthetic) when the spread price was below average, and selling spreads when the price was above. We tried various different ways to parameterize this trade. Due to our position limits, which were relatively small (about 2x the volume on the book at any instant), and the relatively small number of mean-reverting trading opportunities, we realized that timing the trade correctly was critical, and could result in a large amount of additional pnl. 

We tried various approaches in parameterizing this trade. A simple, first-pass strategy was just to set hardcoded prices at which to trade–for example, trading only when the spread deviated from the average value by a certain amount. We backtested to optimize these hardcoded thresholds, and our best parameters netted us ~120k in projected pnl[^7]. However, with this strategy, we noticed that we could lose out on a lot of pnl if the spread price reverted before touching our threshold. To remedy this, we could set our thresholds closer, but then we'd also lose pnl from trading before the spread price reached a local max/min. 

Therefore, we developed a more adaptive algorithm for spreads. We traded on a modified z-score, using a hardcoded mean and a rolling window standard deviation, with the window set relatively small. The idea behind this was that there should be a fundamental reason behind the mean of spread (think the price of the basket itself), but the volatility each day would be less predictable. Then, we thresholded the z-score, selling spreads when our z-score went above a certain value and buying when the z-score dropped below. By using a small window for our rolling standard deviation, we'd see our z-score spike when the standard deviation drastically dropped–and this would often happen right as the price started reverting, allowing us to trade closer to local minima/maxima. This idea bumped our backtest pnl up to ~135k. 


![newplot (2)](https://github.com/ericcccsliu/imc-prosperity-2/assets/62641231/0db11d51-8916-4ed5-83f6-82faeb846267)
<p align="center">
  <em>a plot of spread prices and our modified z-score, as well as z-score thresholds (in green) to trade at</em>
</p>

After results from this round were released, we found that our actual pnl had a significant amount of slippage compared to our backtests–we made only 111k seashells from our algo. Nevertheless, we got a bit lucky–all the teams ahead of us in this round seemed to overfit significantly more, as we were ranked #2 overall.

</details>
<details>
<summary><h2>Round 4️⃣</h2></summary>
  
### Coconuts/coconut coupon :coconut:
Coconuts and coconut coupons were introduced in round 4. Coconut coupons were the 10,000 strike call option on coconuts, with a time to expiry of 250 days. The price of coconuts hovered around 10,000, so this option was near-the-money. 

This round was fairly simple. Using Black-Scholes, we calculated the implied volatility of the option, and once we plotted this out, it became clear that the implied vol oscillated around a value of ~16%. We implemented a mean reverting strategy similar to round 3, and calculated the delta of the coconut coupons at each time in order to hedge with coconuts and gain pure exposure to vol. However, the delta was around 0.53 while the position limits for coconuts/coconut coupons were 300/600, respectively. This meant that we couldn't be fully hedged when holding 600 coupons (we would be holding 18 delta). Since the coupon was far away from expiry (thus, gamma didn't matter as much) and holding delta with vega was still positive ev (but higher var), we ran the variance in hopes of making more from our exposure to vol. 

![newplot (3)](https://github.com/ericcccsliu/imc-prosperity-2/assets/62641231/21fc47f7-727f-48a4-bf4e-b9b9c5fd25a1)

While holding this variance worked out in our backtests, we experienced a fair amount of slippage in our submission–we got unlucky and lost money from our delta exposure. In retrospect, not fully delta hedging might not have been  a smart move–we were already second place and thus should've went for lower var to try and keep the lead. Our algorithm in this round made only 145k, dropping us down to a terrifying 26th place. However, in the results of this round, we saw Puerto Vallarta leap ahead with a whopping profit of 1.2 *million* seashells. We knew we could catch up and end up well within the top 10 if only we could figure out what they did. 
</details>
<details>
<summary><h2>Round 5️⃣</h2></summary>
  
![image](https://github.com/ericcccsliu/imc-prosperity-2/assets/62641231/5d3bbc3b-9d16-473e-a6da-954a84a66da9)

Our leading hypothesis in trying to replicate Puerto Vallarta's profits were that they must've found some way to predict the future–profits on the order of 1.2 million could reasonably match up with a successful stat. arb strategy across multiple symbols. So, we started blasting away with linear regressions on lagged and synchronous returns across all symbols and all days of our data, with the hypothesis that symbols from different days could have correlations that we'd previously missed. However, we didn't find anything particularly interesting here–starfruits seemed to have a bit of lagged predictive power in all other symbols, but this couldn't explain 1.2 million in additional profits.

As a last-ditch attempt in this front, we recalled that last year's competition (which we read about in [Stanford Cardinal's awesome writeup](https://github.com/ShubhamAnandJain/IMC-Prosperity-2023-Stanford-Cardinal)) had many similarities to this competition–especially in the first round, where the symbols we traded basically sounded the exact same. So, we went and sourced last year's data from public GitHub repositories, and performed a linear regression from returns in each of last year's symbols to returns in each symbol of this year. The results we found were surprising: diving gear returns from last year's competition, with a multiplier of ~3, was almost a perfect predictor of roses, with a $R^2$ of 0.99. Additionally, coconuts from last year was a perfect predictor of coconuts from this year, with a beta of 1.25 and an $R^2$ of 0.99.

![image](https://github.com/ericcccsliu/imc-prosperity-2/assets/62641231/64b2c041-b14d-47eb-9c25-df8cb6fcc290)

These discoveries were quite silly, but nonetheless, our goal was to maximize pnl, and as the data from last year was publically available on the internet, we felt like this was still fair game. The rest of our efforts in this competition centered around maximizing the value we could extract from the market with our new knowledge. We believed that many other teams might find these same relationships, and therefore optimization was key.

As a first pass, we simply bought/sold coconuts and roses when our predicted price rose/fell (beyond some threshold to account for spread costs) over a certain number of future iterations. While this worked spectacularly (in comparison to our pnl from literally all previous rounds), we thought we could do better. Indeed, with the data from last year, we had all local maxima/minima, and thus we could theoretically time our trades perfectly and extract max. value. 

To do this systematically across the three symbols we wanted to trade (roses, coconuts, and gift baskets, due to their natural correlation with roses), we developed a dynamic programming algorithm. Our algorithm took many factors into account–costs of crossing spread, the volume we could take at iteration (the volume on the orderbook), and our volume limits.

The motivation behind the complexity of our dp algorithm was the fact that, at each iteration, we couldn't necessarily achieve our full desired position–therefore, we needed a state for each potential position that we could feasibly achieve. A simple example of this is to imagine a product going through the following prices: 
$$8 \rightarrow 7 \rightarrow 12 \rightarrow 10$$
With a position limit of 2, and with sufficient volume on the orderbook, the optimal trades would be: sell 2 -> buy 4 -> sell 4, with a pnl of 16. Now imagine if you could only buy/sell 2 shares at each iteration. Then, the optimal solution would change–you'd want to buy 2 -> buy 2 -> sell 2, with an overall pnl of 14. 

<details>
  <summary>our dp code (click to expand)</summary>

  
```python
def optimal_trading_dp(prices, spread, volume_pct):
    n = len(prices)
    price_level_cnt = math.ceil(1/volume_pct)
    left_over_pct = 1 - (price_level_cnt - 1) * volume_pct

    dp = [[float('-inf')] * (price_level_cnt * 2 + 1) for _ in range(n)]  # From -3 to 3, 7 positions
    action = [[''] * (price_level_cnt * 2 + 1) for _ in range(n)]  # To store actions

    # Initialize the starting position (no stock held)
    dp[0][price_level_cnt] = 0  # Start with no position, Cash is 0
    action[0][price_level_cnt] = ''  # No action at start

    def position(j):
        if j > price_level_cnt:
            position = min((j - price_level_cnt) * volume_pct, 1)
        elif j < price_level_cnt:
            position = max((j - price_level_cnt) * volume_pct, -1)
        else:
            position = 0
        return position
    
    def position_list(list):
        return np.array([position(x) for x in list])

    for i in range(1, n):
        for j in range(0, price_level_cnt * 2 + 1):
            # Calculate PnL for holding, buying, or selling
            hold = dp[i-1][j] if dp[i-1][j] != float('-inf') else float('-inf')
            if j == price_level_cnt * 2:
                buy = dp[i-1][j-1] - left_over_pct*prices[i-1] -  left_over_pct*spread if j > 0 else float('-inf')
            elif j == 1:
                buy = dp[i-1][j-1] - left_over_pct*prices[i-1] -  left_over_pct*spread if j > 0 else float('-inf')
            else:
                buy = dp[i-1][j-1] - volume_pct*prices[i-1] - volume_pct*spread if j > 0 else float('-inf')

            if j ==  0:
                sell = dp[i-1][j+1] + left_over_pct*prices[i-1] - left_over_pct*spread if j < price_level_cnt * 2 else float('-inf')
            elif j == price_level_cnt * 2 - 1:
                sell = dp[i-1][j+1] + left_over_pct*prices[i-1] - left_over_pct*spread if j < price_level_cnt * 2 else float('-inf')
            else:
                sell = dp[i-1][j+1] + volume_pct*prices[i-1] - volume_pct*spread if j < price_level_cnt * 2 else float('-inf')
                
            # Choose the action with the highest PnL

            hold_pnl = hold + (j - price_level_cnt) * position(j) * prices[i]
            buy_pnl = buy + (j - price_level_cnt) * position(j) * prices[i]
            sell_pnl = sell + (j - price_level_cnt) * position(j) * prices[i]
            
            # print(hold_pnl, buy_pnl, sell_pnl)
            best_action = max(hold_pnl, buy_pnl, sell_pnl)
            if best_action == hold_pnl:
                dp[i][j] = hold
            elif best_action == buy_pnl:
                dp[i][j] = buy
            else:
                dp[i][j] = sell

            if best_action == hold_pnl:
                action[i][j] = 'h'
            elif best_action == buy_pnl:
                action[i][j] = 'b'
            else:
                action[i][j] = 's'
    # Backtrack to find the sequence of actions
    trades_list = []
    # Start from the position with maximum PnL at time n-1

    pnl = np.array(dp[n-1]) + (position_list(np.arange(0,price_level_cnt*2+1)) * prices[n-1])
    current_position = np.argmax(pnl)
    for i in range(n-1, -1, -1):
        trades_list.append(action[i][current_position])
        if action[i][current_position] == 'b':
            current_position -= 1
        elif action[i][current_position] == 's':
            current_position += 1

    trades_list.reverse()
    trades_list.append('h')
    return dp, trades_list, pnl[np.argmax(pnl)]  # Return the actions and the maximum PnL

# Example usage
dp, trades, max_pnl = optimal_trading_dp(coconut_past_price, 0.99, 185/300)
# print(trades)
print("Max PnL:", max_pnl)
```


</details>
Our inputs here were prices–we found that generating trades over the predictor timeseries was sufficient due to the high correlation–volume percentage (percent of volume limit on the orderbook at each iteration), and spread (the average spread, cost of each trade), with a target of maximizing pnl. Using this dp algorithm, we generated a string of trades for each symbol, with `'b'` or `'s'` at each index representing the action at each timestamp. Using this algorithm, we achieved an algo pnl of 2.1 million seashells–the highest over all teams in this round! This brought us to a final overall standing of second place.

</details>

For the open-source tools we want to again give credit to [Jasper van Merle](https://github.com/jmerle). For this write up we followed the outline of the excellent report by the second place finish of [linear utility](https://github.com/ericcccsliu/imc-prosperity-2).
