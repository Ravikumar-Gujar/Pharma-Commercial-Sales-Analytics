"""
Pharma Commercial Sales Analytics
Reusable Python analysis script.

Expected input:
    data/processed/salesdaily_processed.csv
    data/processed/saleshourly_processed.csv

Outputs:
    python_analysis/results/*.csv
    python_analysis/visualizations/*.png
"""

from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt

BASE = Path(__file__).resolve().parents[1]
PROCESSED = BASE / "data" / "processed"
OUTPUT = BASE / "python_analysis"
RESULTS = OUTPUT / "results"
FIGURES = OUTPUT / "visualizations"
RESULTS.mkdir(parents=True, exist_ok=True)
FIGURES.mkdir(parents=True, exist_ok=True)

PRODUCTS = ["M01AB", "M01AE", "N02BA", "N02BE", "N05B", "N05C", "R03", "R06"]


def load_data():
    daily = pd.read_csv(PROCESSED / "salesdaily_processed.csv", parse_dates=["datum"])
    hourly = pd.read_csv(PROCESSED / "saleshourly_processed.csv", parse_dates=["datum"])
    return daily, hourly


def product_analysis(daily):
    sales = daily[PRODUCTS].sum().sort_values(ascending=False)
    result = pd.DataFrame({"Product": sales.index, "Total_Sales": sales.values})
    result["Sales_Share_%"] = result["Total_Sales"] / result["Total_Sales"].sum() * 100
    return result


def yearly_analysis(daily):
    yearly = daily.groupby("Year")["Total_Sales"].sum().sort_index()
    result = yearly.rename("Total_Sales").reset_index()
    result["YoY_Growth_%"] = result["Total_Sales"].pct_change() * 100
    return result


def monthly_analysis(daily):
    result = daily.groupby("Month")["Total_Sales"].sum().reset_index()
    return result.sort_values("Month")


def weekday_analysis(daily):
    order = ["Monday", "Tuesday", "Wednesday", "Thursday",
             "Friday", "Saturday", "Sunday"]
    result = daily.groupby("Weekday Name")["Total_Sales"].sum().reindex(order)
    return result.rename("Total_Sales").reset_index()


def hourly_analysis(hourly):
    result = hourly.groupby("Hour")["Total_Sales"].sum().reset_index()
    return result.sort_values("Hour")


def create_figures(product, yearly, monthly, weekday, hourly):
    plt.figure(figsize=(10, 5))
    plt.bar(product["Product"], product["Total_Sales"])
    plt.title("Sales by Product Category")
    plt.xlabel("Product")
    plt.ylabel("Total Sales")
    plt.tight_layout()
    plt.savefig(FIGURES / "product_sales.png", dpi=180)
    plt.close()

    plt.figure(figsize=(10, 5))
    plt.plot(yearly["Year"], yearly["Total_Sales"], marker="o")
    plt.title("Yearly Sales Trend")
    plt.xlabel("Year")
    plt.ylabel("Total Sales")
    plt.tight_layout()
    plt.savefig(FIGURES / "yearly_sales.png", dpi=180)
    plt.close()

    plt.figure(figsize=(10, 5))
    plt.plot(monthly["Month"], monthly["Total_Sales"], marker="o")
    plt.title("Monthly Seasonality")
    plt.xlabel("Month")
    plt.ylabel("Total Sales")
    plt.xticks(range(1, 13))
    plt.tight_layout()
    plt.savefig(FIGURES / "monthly_seasonality.png", dpi=180)
    plt.close()

    plt.figure(figsize=(10, 5))
    plt.bar(weekday["Weekday Name"], weekday["Total_Sales"])
    plt.title("Sales by Weekday")
    plt.xlabel("Weekday")
    plt.ylabel("Total Sales")
    plt.xticks(rotation=30)
    plt.tight_layout()
    plt.savefig(FIGURES / "weekday_sales.png", dpi=180)
    plt.close()

    plt.figure(figsize=(10, 5))
    plt.plot(hourly["Hour"], hourly["Total_Sales"], marker="o")
    plt.title("Hourly Sales Pattern")
    plt.xlabel("Hour")
    plt.ylabel("Total Sales")
    plt.tight_layout()
    plt.savefig(FIGURES / "hourly_sales.png", dpi=180)
    plt.close()


def main():
    daily, hourly = load_data()

    product = product_analysis(daily)
    yearly = yearly_analysis(daily)
    monthly = monthly_analysis(daily)
    weekday = weekday_analysis(daily)
    hourly_result = hourly_analysis(hourly)

    product.to_csv(RESULTS / "product_analysis.csv", index=False)
    yearly.to_csv(RESULTS / "yearly_analysis.csv", index=False)
    monthly.to_csv(RESULTS / "monthly_analysis.csv", index=False)
    weekday.to_csv(RESULTS / "weekday_analysis.csv", index=False)
    hourly_result.to_csv(RESULTS / "hourly_analysis.csv", index=False)

    create_figures(product, yearly, monthly, weekday, hourly_result)

    total_sales = daily["Total_Sales"].sum()
    top_product = product.iloc[0]
    peak_month = monthly.loc[monthly["Total_Sales"].idxmax()]
    peak_weekday = weekday.loc[weekday["Total_Sales"].idxmax()]
    peak_hour = hourly_result.loc[hourly_result["Total_Sales"].idxmax()]

    with open(RESULTS / "python_insights.md", "w", encoding="utf-8") as f:
        f.write("# Python Commercial Sales Insights\n\n")
        f.write(f"- Total recorded sales: **{total_sales:,.2f}**\n")
        f.write(f"- Top product: **{top_product['Product']}** with **{top_product['Total_Sales']:,.2f}** sales.\n")
        f.write(f"- Top product share: **{top_product['Sales_Share_%']:.2f}%**.\n")
        f.write(f"- Peak month: **{int(peak_month['Month'])}**.\n")
        f.write(f"- Highest-sales weekday: **{peak_weekday['Weekday Name']}**.\n")
        f.write(f"- Peak hourly period: **{int(peak_hour['Hour']):02d}:00**.\n")

    print("Python analysis completed successfully.")


if __name__ == "__main__":
    main()
