# bmapdistance
Inquiry distance and duration between locations with Baidu Map API 

使用百度地图API查询两个坐标点的路网距离和行程时间 
支持多种交通方式 
支持多点间查询
# Installation
## Quick installation
```
install.packages("remotes")
remotes::install_github("uwmyuan/bmapsdistance")
```
## legacy (skip this)
```
# Github installation
install.packages("devtools")
devtools::install_github("uwmyuan/bmapsdistance")
```
# Example
## Quick example
Request:
```
set.api.key(YOUR_KEY_HERE)
results = bmapdistance(origin = "39.900677,116.327811",
                       destination = "39.871107,116.385629",
                       mode = "walking")
results
```
Response:
```
$status
[1] "0"

$message
[1] "成功"

$distance_value
[1] "8.4公里"

$distance_text
[1] "8423"

$duration_text
[1] "2小时"

$duration_value
[1] "7207"
```

Note that please replace `YOUR_KEY_HERE` with your private key from [Baidu Map API Console](http://lbsyun.baidu.com/apiconsole/key). Free quota of inquries is supplied daily. A valid key is required if your inquiries exceed daily limit. This package will NOT save or record your key in any way. 

Please also refer to the [instructions](https://github.com/rodazuero/gmapsdistance#example-1) for more examples.

# Troubleshooter
## Dependency
- XML

This package should have been installed when you installed `bmapsdistance`:
```
install.packages("XML")
```
And import the package before run your code.
```
library(XML)
```

# Disclaimer
This code is adapted from [gmapdistance](https://github.com/rodazuero/gmapsdistance) by [@uwmyuan](https://github.com/uwmyuan).
This repo is also maintained by [@uwmyuan](https://github.com/uwmyuan). 
