# ToyotaDrive Dashboard

## Purpose

The ToyotaDrive dashboard provides management with reliable automotive
sales insights using data from the ToyotaDrive data warehouse.

The dashboard connects sales, vehicle, date, dealer, pricing, mileage,
and data-quality information to support business analysis.

## Key Performance Indicators

The dashboard tracks:

- Total vehicles sold
- Total sales revenue
- Average selling price
- Minimum selling price
- Maximum selling price
- Average vehicle mileage
- Sales with incomplete vehicle descriptions

## Sales Analysis

The dashboard provides:

- Monthly sales volume
- Monthly sales revenue
- Monthly average selling price
- Annual sales performance
- Top vehicle manufacturers
- Top vehicle models
- Sales by dealer

## Vehicle Analysis

The dashboard provides:

- Top vehicle makes
- Top vehicle models
- Vehicle sales revenue
- Average selling price by vehicle
- Vehicle description completeness

## Price Analysis

Vehicle sales are grouped into:

- Under $5K
- $5K-$10K
- $10K-$20K
- $20K-$30K
- $30K+

The dashboard shows sales volume, revenue, and average selling price
for each price range.

## Mileage Analysis

Vehicle mileage is grouped into:

- Under 30K
- 30K-60K
- 60K-100K
- 100K+

The dashboard compares sales volume and average selling price across
these mileage groups.

## Data Quality

The warehouse includes validation for:

- Sales row counts
- Vehicle foreign-key relationships
- Date foreign-key relationships
- Dealer foreign-key relationships
- Vehicle description completeness
- Source-to-fact sales alignment

The validated warehouse contains:

- 402,928 sales
- 402,928 populated vehicle keys
- 402,928 populated date keys
- 402,928 populated dealer keys
- 0 orphan vehicle keys
- 0 orphan date keys
- 0 orphan dealer keys

## Business Decisions

Management can use the dashboard to:

1. Identify sales trends over time.
2. Identify high-performing vehicle makes and models.
3. Monitor revenue performance.
4. Compare average selling prices.
5. Analyze the relationship between mileage and selling price.
6. Analyze sales across price ranges.
7. Identify vehicle-data quality issues.
8. Support inventory and pricing decisions.

## Validated Sales KPIs

The completed warehouse currently reports:

- Total sales: **402,928**
- Total revenue: **$5,307,263,887.00**
- Average selling price: **$13,171.74**
- Minimum selling price: **$1.00**
- Maximum selling price: **$230,000.00**
- Average mileage: **70,579**

## Technology

- Python
- Pandas
- NumPy
- PostgreSQL
- Neon PostgreSQL
- SQL
- Matplotlib
- Seaborn
- Plotly
- Google Colab
- GitHub
