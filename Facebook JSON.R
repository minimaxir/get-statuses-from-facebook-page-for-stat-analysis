library(rjson)

username <- "techcrunch"
access_token <- "AAACEdEose0cBAA044RL7n6encSxmTJ4flrSUzeXbF40G3CNOm6UmMMU4NZCQwOwIKWoZCmVdiw1fhOmW6J73ZAl3eTPSj1eeEZBAQZCWk2QZDZD"

count <- 1
iterations <- 100
nrows <- iterations * 25

data<- data.frame(b=rep(NA,nrows), c=rep(NA,nrows),d=rep(NA,nrows),e=rep(NA,nrows),f=rep(NA,nrows),g=rep(NA,nrows),h=rep(NA,nrows))
names(data) <- c("Link Title","Message", "Time Posted (PST)", "# Likes", "# Comments", "Has Question?", "Is Photo?")

getSTDFeedURL <- function(name,token) {
  return (paste("https://graph.facebook.com/", name,"/feed?access_token=", token, sep = ""))
}

sanitize_message <- function(mess) {
  if (!is.null(mess)) {
  newmess <- mess
  newmess <- gsub("\n"," ",newmess)
  newmess <- gsub("\r"," ",newmess)
  newmess <- gsub("\'", "'",newmess)
  newmess <- substring(newmess,1,min(nchar(newmess),200))
  if (nchar(mess)>200) newmess <- paste(newmess,"...",sep="")
  }
  return (newmess)
}

feedURL <- getSTDFeedURL(username,access_token)



for (i in 1:iterations) {
  JSON_data <- fromJSON(paste(readLines(feedURL), collapse=""))
  
  for (JSONindex in 1:25) {
    
    link <- JSON_data$data[JSONindex][[1]]
    try ({
      title <- ifelse(!is.null(link$link),paste("=HYPERLINK(\"",sanitize_message(link$link),"\",\"",ifelse(link$type=="photo","[Photo]",ifelse(!is.null(link$name),link$name,"[No Title]")),"\")",sep=""),"[No Title]")
      message<- paste("=HYPERLINK(\"",link$actions[[1]]$link,"\",\"",ifelse(!is.null(link$message),sanitize_message(link$message),"[Empty Message]"),"\")",sep="")
      
      time <- format(strptime(link$created_time,"%Y-%m-%dT%H:%M:%S")-8*60*60, "%m-%d-%y %H:%M:%S")
      numLikes <- as.numeric(link$likes$count)
      numComments <- as.numeric(link$comments$count)
      isQuestion <- ifelse(grepl("?",link$message,fixed=T),"Yes","No")
      isPhoto <-ifelse(link$type=="photo","Yes","No")
      
      
      data[count,]<-c(title, message, time, numLikes, numComments, isQuestion, isPhoto)
      
    }, silent=T)
    
    count <- count + 1
    feedURL <- JSON_data[[2]]$'next'
  }
}
data <- na.omit(data)


data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])

write.table(data, paste(username,"-Status.txt",sep=""),sep="\t",row.names=F,qmethod="d")