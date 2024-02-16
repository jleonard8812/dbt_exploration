import pandas as pd

# Load the dataset
df = pd.read_csv('/Users/lilrawj/Downloads/archive/scrubbed.csv')

# Remove leading and trailing spaces from column names
df.columns = df.columns.str.strip()
print (df.columns)

# Now we will handle each column..
# Convert 'datetime_column' to datetime format
df['datetime'] = pd.to_datetime(df['datetime'], errors='coerce')
# Capitalize City names
df['city'] = df['city'].str.title()
# Capitalize States
df['state'] = df['state'].str.upper()
# Capitalize country
df['country'] = df['country'].str.upper()
# Capitalize shape
df['shape'] = df['shape'].str.title()
# Convert 'date posted' to datetime format
df['date posted'] = pd.to_datetime(df['date posted'], errors='coerce')

# Extract year and month from the 'datetime' column
df['year'] = df['datetime'].dt.year
df['month'] = df['datetime'].dt.month


df['latitude'] = df['latitude'].apply(pd.to_numeric, errors='coerce').round(3)
df['longitude'] = df['longitude'].apply(pd.to_numeric, errors='coerce').round(3)

# df.columns = df.columns.str.capitalize()
# Display specific columns for the first few rows
columns_to_display = ['duration (seconds)', 'duration (hours/min)', 'comments', 'date posted', 'year', 'month']
print(df[columns_to_display].head())
