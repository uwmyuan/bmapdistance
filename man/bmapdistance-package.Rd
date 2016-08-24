\name{bmapdistance-package}
\alias{bmapdistance-package}
\alias{bmapdistance}
\docType{package}
\title{
\packageTitle{bmapdistance}
}
\description{
\packageDescription{bmapdistance}
}
\details{

The DESCRIPTION file:
\packageDESCRIPTION{bmapdistance}
\packageIndices{bmapdistance}
~~ An overview of how to use the package, including the most important functions ~~
}
\author{
\packageAuthor{bmapdistance}

Maintainer: \packageMaintainer{bmapdistance}
}
\references{
lbsyun.baidu.com/index.php?title=webapi/route-matrix-api-v2
}

\examples{
library(bmapdistance)
set.api.key("E4805d16520de693a3fe707cdc962045")
d=bmapdistance("40.45,116.34","40.34,116.45","driving")
}
