from fastapi import FastAPI, Query
from typing import Optional
import pandas as pd

app = FastAPI(title="Population Data API")

# Load CSV and clean
df = pd.read_csv("population_api/Data/2021_population.csv", encoding='utf-8-sig')
df.columns = df.columns.str.strip()

@app.get("/")
def root():
    return {"message": "Welcome to the Population Data API"}

@app.get("/population")
def get_population(country: Optional[str] = Query(None, description="Country name to filter by")):
    if country:
        filtered = df[df['country'].str.lower() == country.lower()]
        if filtered.empty:
            return {"error": f"No data found for country: {country}"}
        return filtered.to_dict(orient="records")
    return df.to_dict(orient="records")
