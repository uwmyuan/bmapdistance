\name{bmapsdistance}
\alias{bmapsdistance}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
bmapdistance
}
\description{
Find distance between two points with baidu map api.
}
\usage{
bmapsdistance(origins, destinations, mode)
}

\examples{
library(bmapdistance)
Set.api.key("E4805d16520de693a3fe707cdc962045")
d=bmapdistance("40.45,116.34","40.34,116.45","driving")
}

