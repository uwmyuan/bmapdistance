\name{bmapsdistance}
\alias{bmapsdistance}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
bmapsdistance(origins, destinations, mode)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{origins}{
%%     ~~Describe \code{origins} here~~
}
  \item{destinations}{
%%     ~~Describe \code{destinations} here~~
}
  \item{mode}{
%%     ~~Describe \code{mode} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (origins, destinations, mode) 
{
    if (is.null(get.api.key())) {
        stop("API KEY IS NOT SET!")
    }
    if (!(mode \%in\% c("driving", "walking", "riding"))) {
        stop("Mode of transportation not recognized. Mode should be one of ", 
            "'riding', 'driving', 'walking' ")
    }
    if (!(get.traffic_model() \%in\% c("10", "11", "12", "13"))) {
        stop("Traffic model not recognized. Traffic model should be one of ", 
            "'10', '11', '12', '13'")
    }
    if (!(get.coord.type() \%in\% c("bd09ll", "bd09mc", "gcj02", 
        "wgs84"))) {
        stop("Traffic model not recognized. Traffic model should be one of ", 
            "bd09ll',  'bd09mc', 'gcj02', 'wgs84'")
    }
    url = paste0("http://api.map.baidu.com/routematrix/v2/", 
        mode, "?", "&output=xml", "&origins=", origins, "&destinations=", 
        destinations, "&coord_type=", get.coord.type())
    if (mode == "driving") {
        if (get.traffic_model() != "12") {
            url = paste0(url, "&tactics=", get.traffic_model())
        }
    }
    key = gsub(" ", "", get.api.key())
    url = paste0(url, "&ak=", key)
    webpageXML = xmlParse(getURL(url))
    results = xmlChildren(xmlRoot(webpageXML))
    d = list()
    d$status = xmlValue(xmlChildren(results$status)$text)
    d$message = xmlValue(results$message)
    d$distance_value = xmlValue(xmlChildren(xmlChildren(results$result)$distance)$text)
    d$distance_text = xmlValue(xmlChildren(xmlChildren(xmlChildren(results$result)$distance)$value)$text)
    d$duration_text = xmlValue(xmlChildren(xmlChildren(xmlChildren(results$result)$duration)$text)$text)
    d$duration_value = xmlValue(xmlChildren(xmlChildren(xmlChildren(results$result)$duration)$value)$text)
    return(d)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
