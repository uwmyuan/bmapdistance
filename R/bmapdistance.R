#'Acknowledge the project https://github.com/rodazuero/gmapsdistance
#' Define package environment
#'
#' \code{pkg.env} is a package environment that contains the variable
#' \code{api.key} with the user's Baidu Maps API key
pkg.env = new.env()
assign("ak", NULL, envir = pkg.env)
assign("coord_type", "gcj02", envir = pkg.env)
assign("traffic_model","13", envir = pkg.env)
#' Get the Baidu Maps API key
#'
#' This function returns the user's Baidu Maps API key that was defined with
#' \code{set.api.key}.
#'
#' @return the user's api key
#' @examples
#' get.api.key()
get.api.key = function() {
    get("ak", envir = pkg.env)
}
get.coord.type=function(){
  get("coord_type", envir = pkg.env)
}
get.traffic_model=function(){
  get("traffic_model", envir = pkg.env)
}
#' Set the Baidu Maps API key
#'
#' This function stores a user's Baidu Maps API key as the package's
#' environmental variable
#'
#' @param key is the user's Baidu Maps API key
#' @examples
#' #DONTRUN
#' set.api.key("MY-Baidu-MAPS-API-KEY")
set.api.key = function(key) {
    assign("ak", key, envir = pkg.env)
}
set.coord.type=function(coord_type){
	assign("coord_type",coord_type, envir=pkg.env)
}
set.traffic_model=function(traffic_model){
  set("traffic_model", traffic_model, envir = pkg.env)
}
#' Compute Route Matrix with Baidu Maps
#'
#' The function bmapdistance uses the Baidu Maps Route Matrix API v2 in order
#' to compute the Route Matrix between coordernated pionts.
#' Please refer the api page http://lbsyun.baidu.com/index.php?title=webapi/route-matrix-api-v2
#' @title bmapdistance
#' @usage bmapdistance(origin, destination, mode, key)
#' @param origin  A string containing the description of the starting point.
#'   Should be inside of quoutes (""). Coordinates in
#'   "LAT,LONG" format are only a valid input by Baidu Maps. 
#'	If more than one point are used, "|" is used to seperate different coordernates of points.
#' @param destination A string containing the description of the end point.
#'   Should be the same format as the variable "origin".
#' @param mode A string containing the mode of transportation desired. Should be
#'   inside of double quotes (",") and one of the following: "riding",
#'   "walking", "driving".
#' @param key In order to use the Baidu Maps Distance Matrix API it is
#'   necessary to have an API key. The key should be inside of quotes. Example:
#'   "THISISMYKEY". This key an also be set using \code{set.api.key("THISISMYKEY")}.
#' @return a list with the traveling duration and distance in text and number between origin and
#'   destination and the status
#' @examples
#' set.api.key("E4805d16520de693a3fe707cdc962045")
#' bmapdistance("40.056878","116.30815", "40.063597|116.364973", "driving")
#' {"status":0,"result":[{"distance":{"text":"19.7????","value":19749},"duration":{"text":"30????",
#'	"value":1812}},{"distance":{"text":"21.3????","value":21255},"duration":{"text":"32????","value"
#'	:1934}},{"distance":{"text":"45.8????","value":45776},"duration":{"text":"1.2Сʱ","value":4402}
#'	},{"distance":{"text":"47.3????","value":47282},"duration":{"text":"1.3Сʱ","value":4524}}],"message":"?ɹ?"}
bmapdistance = function(origins, destinations, mode) {
	#If ak is not set:
  if(is.null(get.api.key())){
		stop("API KEY IS NOT SET!")
	}
	
	# If mode of transportation not recognized:
  if (!(mode %in% c("driving",  "walking",  "riding"))) {
      stop(
          "Mode of transportation not recognized. Mode should be one of ",
          "'riding', 'driving', 'walking' ")
  }

	# If traffic_model is not recognized:
  if (!(get.traffic_model() %in% c("10",  "11", "12", "13"))) {
    stop(
      "Traffic model not recognized. Traffic model should be one of ",
      "'10', '11', '12', '13'"
    )
  }
	# If coord_type is not recognized:
  if (!(get.coord.type() %in% c("bd09ll",  "bd09mc", "gcj02", "wgs84"))) {
    stop(
      "Coord type not recognized. Traffic model should be one of ",
      "bd09ll',  'bd09mc', 'gcj02', 'wgs84'"
    )
  }
	# Set up URL
  url = paste0("http://api.map.baidu.com/routematrix/v2/", mode, "?",
	  "output=xml",
          "&origins=", origins,
          "&destinations=", destinations,
	  "&coord_type=", get.coord.type()
	)
    if(mode=="driving"){
		if(get.traffic_model()!="12"){
	  	  url=paste0(url,"&tactics=", get.traffic_model())
		  }
	}
	# use Baidu maps key (after replacing spaces just in case)
  key = gsub(" ", "", get.api.key())
  url = paste0(url, "&ak=", key)
    
	# Call the Baidu Maps Webservice and store the XML output in webpageXML
  webpageXML = xmlParse(getURL(url));
      
	# Extract the results from webpageXML
  results = xmlChildren(xmlRoot(webpageXML))

	#convert xml to data
  d=list()
  d$status = xmlValue(xmlChildren(results$status)$text)
  d$message = xmlValue(results$message)
  d$distance_value = xmlValue(xmlChildren(xmlChildren(results$result)$distance)$text)
  d$distance_text = xmlValue(xmlChildren(xmlChildren(xmlChildren(results$result)$distance)$value)$text)
  d$duration_text = xmlValue(xmlChildren(xmlChildren(xmlChildren(results$result)$duration)$text)$text)
	d$duration_value = xmlValue(xmlChildren(xmlChildren(xmlChildren(results$result)$duration)$value)$text)
	
	#output data
  return(d)    
}
