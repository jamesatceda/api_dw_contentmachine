# api_dw_contentmachine

The goal of this repository is to demonstrate how to collect data from the Australian Bureau of Statistics (ABS) API and upload that data to Datawrapper for chart creation.  Two different API keys are required:

- `ABS_API_KEY` – used by the `readabs` package to access the ABS API
- `DW_API_KEY` – used to authenticate with Datawrapper

## Example script

The `national_accounts_to_dw.R` script shows a simple workflow that downloads the national accounts time series and publishes it to Datawrapper.  The script expects the API keys to be available as environment variables.

```r
Sys.setenv(ABS_API_KEY = "your-abs-key")
Sys.setenv(DW_API_KEY = "your-datawrapper-key")

source("national_accounts_to_dw.R")
```

Running the script will create (or update) a Datawrapper chart with the latest quarterly GDP data.
