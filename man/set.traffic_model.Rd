\name{set.traffic_model}
\alias{set.traffic_model}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
set user's traffic model
}
\description{
只对驾车算路(driving)生效。  
可选值：10 不走高速；11 最短时间；12 最短路径；13 最短 距离(不考虑路况);  
其中10-12 都考虑实时路况，若希望计算最可靠的最短路线距离，建议使用不考虑实时路况的默认值13。3??
}
\usage{
set.traffic_model(traffic_model)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{traffic_model}{
%%     ~~Describe \code{traffic_model} here~~
}
}
\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
set.traffic_model("13")
}

