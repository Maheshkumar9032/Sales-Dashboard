# 📊 E-Commerce Sales Dashboard

A multi-page Power BI dashboard analyzing Brazilian e-commerce transaction data, covering revenue trends, order behavior, customer loyalty, and product performance. Built end-to-end using PostgreSQL for data extraction and Power BI for visualization and DAX measures.

---

## 📸 Dashboard Preview

### Revenue Overview
![Revenue Overview](./Assets/revenue_overview.png)

### Order Behaviour
![Order Behaviour](./Assets/order_behaviour.png)

### Product Performance
![Product Performance](./Assets/product_performance.png)

### Customer Behaviour
![Customer Behaviour](./Assets/customer_behaviour.png)

---

## 🔍 Key Business Insights

- **Revenue is highly concentrated** — the top 10% of orders generate **41.1% of total revenue**, indicating over-reliance on a small number of high-value transactions and a significant business risk if those customers churn

- **Retention is the biggest gap** — only **3.12% of customers return**, with an average gap of **79 days** between purchases, signaling weak loyalty loops and a major opportunity for retention campaigns

- **Frequent buyers and at-risk buyers are nearly equal** — the customer segment chart shows 1,052 frequent buyers vs 940 at-risk customers, meaning a large portion of seemingly loyal customers are on the verge of churning — a nuanced finding that challenges surface-level loyalty metrics

- **Peak ordering window is Monday at 4pm** — with 18,400 orders on Mondays and hour 16 as the busiest hour, this is a clear, actionable targeting window for email campaigns, push notifications, and promotions

- **A high-AOV niche exists but is underexplored** — the `pcs` category averages **$7,400 per order** vs the business average of $137, nearly 54x higher, representing a premium segment that could benefit from dedicated marketing strategy

- **Sao Paulo drives disproportionate customer loyalty** — 502 repeat customers in Sao Paulo vs 236 in Rio de Janeiro, suggesting geographic concentration of engaged buyers and where retention spend would have the highest ROI

---

## 📁 Project Structure

```
ecommerce-sales-dashboard/
├── README.md
├── dashboard/
│   └── Sales_Dashboard.pbix
├── sql/
│   ├── 01_data_validation.sql
│   ├── 01_monthly_revenue_trend.sql
│   ├── 01_product_categories_by_revenue.sql
│   ├── 01_repeat_customers_percentage.sql
│   ├── 01_peak_hours_and_days.sql
│   ├── 01_states_revenue_per_customer.sql
│   ├── 02_avg_time_between_purchases.sql
│   ├── 02_avg_items_per_order.sql
│   ├── 02_monthly_order_growth_rate.sql
│   ├── 02_cities_high_orders_low_revenue.sql
│   ├── 02_frequently_purchased_together.sql
│   ├── 03_highest_revenue_months.sql
│   ├── 03_customer_segment_by_purchase_gap.sql
│   ├── 03_high_revenue_low_volume_products.sql
│   ├── 04_top_10_percent_order_revenue.sql
│   ├── 04_highest_average_order_value_categories.sql
│   ├── 04_cities_with_most_repeat_customers.sql
│   └── 05_top_10_customers_by_revenue.sql
└── assets/
        ├── revenue_overview.png
        ├── order_behaviour.png
        ├── product_performance.png
        └── customer_behaviour.png
```

---

## 📊 Dashboard Pages

### 1. Revenue Overview
Answers the question: *how is the business performing overall?*

| Metric | Value |
|---|---|
| Total Revenue | $13.59M |
| Revenue Share | Dynamic (filters by category) |
| Count of Products Sold | 112.65K |

**Visuals:**
- Revenue by Category — horizontal bar chart of top 10 categories
- Monthly Revenue Trend — bar chart showing growth from 2016 to 2018

**Features:**
- Category slicer filters all 3 cards and both charts simultaneously
- Revenue Share % updates dynamically to show selected category's share of total revenue

---

### 2. Order Behaviour
Answers the question: *when do customers buy, and how are orders distributed?*

| Metric | Value |
|---|---|
| Peak Day | Monday |
| Peak Hour | 16:00 |
| Count of Products Sold | 112.65K |

**Visuals:**
- Order Count per Day — bar chart sorted Monday to Saturday
- Revenue from Top 10% Orders — donut chart showing 41.1% revenue concentration

---

### 3. Product Performance
Answers the question: *which products and categories drive the most value?*

| Visual | Insight |
|---|---|
| Revenue by Category | beleza_saude leads at $1.26M |
| Average Order Value by Category | pcs leads at $7.4K — 54x the business average |
| Frequently Purchased Together | moveis_decoracao + cama_mesa_banho is the top pair (48 co-purchases) |

---

### 4. Customer Behaviour
Answers the question: *how loyal are customers and where are they?*

| Metric | Value |
|---|---|
| Repeat Customer Rate | 3.12% |
| Avg Order Gap | 79.15 days |
| Total Repeat Customers | ~3,000 |

**Visuals:**
- Customer Segment by Order Gap — Frequent / Regular / Occasional / At Risk
- Repeat Customers per City — Sao Paulo leads with 502 repeat customers

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| PostgreSQL | Data extraction, transformation, and analysis |
| Power BI Desktop | Dashboard building and visualization |
| DAX | Custom measures (Revenue Share %, Peak Day, Peak Hour, Monthly Growth Rate) |
| pgAdmin | SQL query execution and validation |
| GitHub | Version control and project showcase |

---

## 🗄️ Database Schema

The analysis is built on 4 core tables:

```
customers        — customer_id, customer_unique_id, city, state
orders           — order_id, customer_id, order_purchase_timestamp, order_status
order_items      — order_id, product_id, price, order_item_id
products         — product_id, product_category_name
```

**Key relationships:**
- `customers` → `orders` via `customer_id`
- `orders` → `order_items` via `order_id`
- `order_items` → `products` via `product_id`

---

## 📐 Key DAX Measures

**Revenue Share %**
```dax
Revenue Share % =
DIVIDE(
    SUM(order_items[price]),
    CALCULATE(
        SUM(order_items[price]),
        ALL(products[product_category_name])
    )
)
```

**Peak Day**
```dax
Peak Day =
CALCULATE(
    FIRSTNONBLANK(orders[Day Name], 1),
    TOPN(
        1,
        ALL(orders[Day Name]),
        CALCULATE(COUNT(orders[order_id])),
        DESC
    )
)
```

**Peak Hour**
```dax
Peak Hour =
CALCULATE(
    FIRSTNONBLANK(orders[Hour Number], 1),
    TOPN(
        1,
        ALL(orders[Hour Number]),
        CALCULATE(COUNT(orders[order_id])),
        DESC
    )
)
```

**Repeat Customer %**
```dax
Repeat Customer % =
VAR TotalCustomers =
    COUNTROWS(SUMMARIZE(customers, customers[customer_unique_id]))
VAR RepeatCustomers =
    COUNTROWS(
        FILTER(
            SUMMARIZE(
                customers,
                customers[customer_unique_id],
                "order_count", CALCULATE(COUNT(orders[order_id]))
            ),
            [order_count] > 1
        )
    )
RETURN
    DIVIDE(RepeatCustomers, TotalCustomers)
```

---

## 💡 SQL Analysis Coverage

| # | Question | File |
|---|---|---|
| 1 | What is the monthly revenue trend? | `01_monthly_revenue_trend.sql` |
| 2 | Which product categories generate the most revenue? | `01_product_categories_by_revenue.sql` |
| 3 | What % of customers are repeat customers? | `01_repeat_customers_percentage.sql` |
| 4 | What are the peak hours or days for orders? | `01_peak_hours_and_days.sql` |
| 5 | Which states generate the highest revenue per customer? | `01_states_revenue_per_customer.sql` |
| 6 | What is the avg time between purchases for repeat customers? | `02_avg_time_between_purchases.sql` |
| 7 | What is the average number of items per order? | `02_avg_items_per_order.sql` |
| 8 | What is the monthly order growth rate? | `02_monthly_order_growth_rate.sql` |
| 9 | Which cities have high orders but low revenue? | `02_cities_high_orders_low_revenue.sql` |
| 10 | Which products are frequently purchased together? | `02_frequently_purchased_together.sql` |
| 11 | Which months generated the highest revenue? | `03_highest_revenue_months.sql` |
| 12 | What is the customer segment based on purchase gap? | `03_customer_segment_by_purchase_gap.sql` |
| 13 | Which products generate high revenue but low volume? | `03_high_revenue_low_volume_products.sql` |
| 14 | What % of revenue comes from top 10% of orders? | `04_top_10_percent_order_revenue.sql` |
| 15 | Which categories have the highest average order value? | `04_highest_average_order_value_categories.sql` |
| 16 | Which cities have the most repeat customers? | `04_cities_with_most_repeat_customers.sql` |
| 17 | Who are the top 10 customers by revenue? | `05_top_10_customers_by_revenue.sql` |

---

## 🚀 How to Use

1. Clone the repository
```bash
git clone https://github.com/yourusername/ecommerce-sales-dashboard.git
```

2. Run the SQL files in pgAdmin against your PostgreSQL database in numbered order starting with `01_data_validation.sql`

3. Open `dashboard/Sales_Dashboard.pbix` in Power BI Desktop

4. Update the data source connection to point to your PostgreSQL instance under **Transform Data → Data Source Settings**

5. Refresh the data and all visuals will populate automatically

---

## 👤 Author

**Mahesh**
- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [your-linkedin](https://linkedin.com/in/your-linkedin)

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).