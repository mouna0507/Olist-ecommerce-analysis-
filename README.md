# Olist E-Commerce Analysis: Revenue, Delivery & Retention

**[View the interactive Tableau dashboard](PASTE_YOUR_TABLEAU_LINK_HERE)**

![Dashboard preview](dashboard.png)

## Business question

Where is Olist's revenue coming from, what drives customer satisfaction, and do customers come back? And based on that, what should revenue look like over the next six months?

## Tools

| Tool | Used for |
|---|---|
| **SQL** (SQLite, DB Browser for SQLite) | Joining and aggregating ~100k orders across 8 tables |
| **Excel** | Driver-based revenue forecast, scenarios, and sensitivity analysis |
| **Tableau Public** | Interactive dashboard |

**Data:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) (Kaggle). Raw data is not included in this repo; download it from Kaggle to reproduce the analysis.

---

## Key findings

1. **Growth comes from more orders, not bigger orders.** Monthly orders grew roughly 7x, while average order value (AOV) stayed in a narrow band (R$124–149).
2. **Black Friday drives the year's peak.** Orders jumped 63% in November 2017, then fell back in December.
3. **Health & Beauty leads revenue; Watches & Gifts earn the most per order.** High-priced categories generate strong revenue from fewer orders, while categories like housewares depend on volume.
4. **8.13% of delivered orders arrived late.**
5. **Late deliveries hurt reviews.** Late orders averaged **2.57 stars** vs. **4.29** for on-time orders, a 1.72-star (about 40%) drop.
6. **RJ is the priority market for delivery.** Northeastern states such as AL have the highest late rates but low volume. RJ combines high volume (12,310 orders) with an above-average late rate (13.52%), so it affects the most customers. SP and MG, the largest markets, perform well.
7. **Retention is very low.** Only **3.0%** of customers placed more than one order. The most frequent customer placed 15 orders over more than a year, a rare example of genuine loyalty.

## Recommendations

- **Improve delivery reliability, starting with RJ**, to protect review scores where the most customers are affected.
- **Invest in retention.** With 97% one-time buyers, growth depends almost entirely on new customer acquisition. Even a small increase in repeat purchases would add meaningful revenue, and better delivery performance supports this.
- **Test tactics to raise AOV**, such as free-shipping thresholds, bundles, and "frequently bought together" recommendations. AOV is a strong lever on paper but has barely moved historically.
- **Plan inventory and delivery capacity for Black Friday**, when volume runs about 60% above a normal month.

---

## Revenue forecast (Excel)

A driver-based model: **Revenue = Orders × Average Order Value**, forecasting September 2018 to February 2019.

| Assumption | Value | Basis |
|---|---|---|
| Base growth | 2% / month | 2018 average month-over-month growth |
| Best case | 3% / month | Close to the full-period median |
| Worst case | 0% / month | Growth stalls |
| AOV | R$136.80 | 2018 average |
| November factor | 1.6x | Nov 2017 vs. Oct 2017 (Black Friday) |
| December factor | 1.2x | Dec 2017 vs. Oct 2017 |

**6-month revenue forecast:**

| Scenario | Orders | Revenue |
|---|---|---|
| Best | 48,322 | R$6.61M |
| Base | 46,684 | R$6.39M |
| Worst | 43,561 | R$5.96M |

- Without the seasonal adjustment, November 2018 would have been underestimated by roughly 4,200 orders.
- **Sensitivity analysis:** across growth of 0–4% and AOV ±10%, 6-month revenue ranges from R$5.36M to R$7.53M. A 5% change in AOV moves revenue about 5%; a 1-point change in monthly growth moves it about 3.5%.
- The model uses a scenario dropdown, a Data Table for side-by-side scenarios, and color-coded input cells.

---

## Analysis decisions

- **Revenue** = sum of item prices for **delivered** orders only (completed and least likely to be canceled). Shipping (freight) is excluded.
- **Analysis window:** January 2017 to August 2018. 2016 was excluded due to very low volume and missing months; August 2018 was kept because its volume matched prior months.
- **Late delivery** = actual delivery date after the estimated date. `days_late` = actual − estimated, so positive values mean late.
- **Customers** were counted by `customer_unique_id` (the person), not `customer_id`, which Olist creates new for every order.
- **Forecast growth** uses the 2018 average (2%) rather than the full-period average (16%), which was inflated by very fast growth from a small base in early 2017.

## Data quality notes

- 97% of orders (96,478 of 99,441) have status "delivered."
- A small number of delivered orders have no recorded delivery date and were excluded from delivery analysis.
- Category order counts can overlap, since one order may include products from several categories.
- A small number of orders have multiple reviews; all were included in averages.
- Seasonal factors are based on a single year (2017) and should be treated as estimates.

---

## Repository contents

| File | Description |
|---|---|
| `sql/01_monthly_orders.sql` | Delivered orders per month |
| `sql/02_monthly_revenue.sql` | Monthly orders, revenue, and AOV |
| `sql/03_revenue_by_category.sql` | Top 10 categories by revenue, with orders and AOV (4-table join) |
| `sql/04_late_delivery_rate.sql` | Overall late delivery rate |
| `sql/05_reviews_by_delivery.sql` | Average review score, late vs. on time |
| `sql/06_late_rate_by_state.sql` | Late rate and order volume by state |
| `sql/07_repeat_customers.sql` | Customers with more than one order |
| `sql/08_repeat_rate.sql` | Overall repeat customer rate (subquery) |
| `olist_analysis.xlsx` | Query results, forecast model, scenarios, and sensitivity table |
| `dashboard.png` | Dashboard screenshot |

**SQL skills shown:** multi-table joins, aggregation, `GROUP BY` / `HAVING`, `CASE` logic, date calculations with `julianday`, conditional counting, subqueries, and `NULL` handling.

## How to reproduce

1. Download the dataset from Kaggle.
2. In DB Browser for SQLite, create a new database and import each CSV as a table (`orders`, `order_items`, `customers`, `products`, `product_name`, `order_reviews`, `payments`, `sellers`).
3. Run the queries in the `sql/` folder in order.
