library(httr)
library(jsonlite)
library(tidyverse)
library(kableExtra)
# Define the CKAN Data API endpoint
api_url = "https://open.canada.ca/data/en/api/3/action/datastore_search"

# Specify the Resource ID of the dataset
resource_id = "22653cdd-d1e2-4c04-9d11-61b5cdd79b4e"

# Initialize an empty dataframe
df_1 = data.frame()

# Set batch size
batch_size = 1000  # Adjust batch size if needed
offset = 0  # Start at record 0

# Fetch data iteratively
repeat {
  response = GET(api_url, query = list(resource_id = resource_id, limit = batch_size, offset = offset))
  data = content(response, "text") %>% fromJSON(flatten = TRUE)
  
  # Extract records and bind to df
  new_data = as.data.frame(data$result$records)
  
  # Stop if no new data is returned
  if (nrow(new_data) == 0) break
  
  df_1 = bind_rows(df_1, new_data)
  
  # Update offset for next batch
  offset = offset + batch_size
}