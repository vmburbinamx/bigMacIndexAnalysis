# This script generates the Excel file for download

# library('r2excel') 'Original version
library('writexl') 
# writexl library works well in 3.5.1
library('magrittr')
library('data.table')
library('tidyr')
library('dplyr')

data = fread('./output-data/big-mac-full-index.csv') %>%
    .[, .(
        Country = name,
        iso_a3,
        currency_code,
        local_price,
        dollar_ex,
        dollar_price,
        dollar_ppp = dollar_ex * dollar_price / .SD[currency_code == 'USD']$dollar_price,
        GDP_dollar,
        dollar_valuation = USD_raw * 100,
        euro_valuation = EUR_raw * 100,
        sterling_valuation = GBP_raw * 100,
        yen_valuation = JPY_raw * 100,
        yuan_valuation = CNY_raw * 100,
        dollar_adj_valuation = USD_adjusted * 100,
        euro_adj_valuation = EUR_adjusted * 100,
        sterling_adj_valuation = GBP_adjusted * 100,
        yen_adj_valuation = JPY_adjusted * 100,
        yuan_adj_valuation = CNY_adjusted * 100
    ), by=date]

dates = data$date %>% unique

# wb = createWorkbook(type='xls')
# 
# for(sheetDate in sort(dates, decreasing = T)) {
#     dateStr = sheetDate %>% strftime(format='%b%Y')
#     sheet = createSheet(wb, sheetName = dateStr)
#     xlsx.addTable(wb, sheet, data[date == sheetDate, -1], row.names=FALSE, startCol=1)
# }
# 
# saveWorkbook(wb, paste0('./output-data/big-mac-',max(dates),'.xls'))

# Instead of writing one page per delivery (date), this line creates a file with a single tab in Excel
write_xlsx(data, path = "output-data/bigmac.xlsx")

# Create tidy data to produce visualizations in Shiny


# saveRDS(data, file = "summarizedData.rds")

rm(list = ls())
