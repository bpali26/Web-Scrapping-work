
#Scraping the countries list

url1<-"http://www.alexa.com/topsites/countries"
doc1<-htmlParse(url1)
links <- xpathSApply(doc1, "//li/a/@href")
links_names<- xpathSApply(doc1, "//li/a",xmlValue)
links_names<- links_names[11:201]
urls1<-paste0(rep(c("http://www.alexa.com"),191),links[11:201])

#Scrapping Top 50 website list from each country

sites<-c()
website<-c()
urls<-list()
for(m in 1:191){
  doc <- htmlParse(urls1[m])
  links <- xpathSApply(doc, "//a/@href")
  sites<-links[27:76]
  sites<-strsplit(sites,split="/")
  for(i in 1:length(sites)){
    website[i]<-sites[[i]][3]
  }
  website<-paste0(rep("http://data.danetsoft.com/",50),website)
  urls[[m]]<-website
}

#Scrapping out the basic information of each website under 191 countries:

upper_data<-list()

for(i in 1:191){urls[[i]]<-gsub("www.","",urls[[i]])}
counter<-0
mounter<-0
site<-c()

for(m in 1:191){ 
  data<-vector("list",length=50)
  
  for(j in 1:50){
    
    doc <- try(doc <- htmlParse(urls[[m]][j]))
    if(class(doc) == "try-error"){
      site<-c(site,urls[[m]][j])
      next
      }
    
    link1 <- xpathSApply(doc, "//div/strong[@class='description__item-heading']", xmlValue)
    link2 <- xpathSApply(doc, "//div/span[@class='description__item-text']", xmlValue)
    link3 <- xpathSApply(doc, "//li/strong[@class='info__section-title']", xmlValue)
    link4 <- xpathSApply(doc, "//li/span[@class='info__section-val']", xmlValue)
    link5 <- xpathSApply(doc, "//td", xmlValue)
    
    #processing
    d<-c() 
    link3<-strsplit(link3,split=":")
    for(i in 1:6) {d[i]<-strsplit(link3[[i]][1],split="\t")}
    b<-c()
    for(i in 1:6) b[i]<-d[[i]][15]
    b[7]<-link3[[7]]
    
    data1<-data.frame(link1,link2)
    colnames(data1)<-c("attribute","value")
    data2<-data.frame(b,link4)
    colnames(data2)<-c("attribute","value")
    
    link5.1<-link5[c(1,seq(4,16,by=3))]
    link5.2<-link5[c(2,seq(5,17,by=3))]
    link5.3<-link5[seq(6,18,by=3)]
    link5.4<-link5[seq(19,27,by=2)]
    link5.5<-link5[seq(20,28,by=2)]
    
    link5.3<-strsplit(link5.3,split="%")
    
    a<-c()
    for(i in 1:5) {a[i]<-strsplit(link5.3[[i]][1],split="\t")}
    c<-c()
    for(i in 1:5) c[i]<-a[[i]][17]
    
    data3<-data.frame(link5.1,link5.2)
    colnames(data3)<-c("attribute","value")
    data4<-data.frame(paste(link5.1[2:6],rep("%",5),sep="_"),c)
    colnames(data4)<-c("attribute","value")
    data5<-data.frame(link5.4,link5.5)
    colnames(data5)<-c("attribute","value")
    
    data[[j]]<-rbind(data1,data2,data3,data4,data5)
    counter<-counter+1
  }
  mounter<-mounter+1
  data<-Filter(length,data)
  df1 <- do.call("rbind", data)

  df1<-data.frame(df1,data.frame(website=rep(urls[[m]][!urls[[m]] %in% site],each=29)))
  df1<-reshape(df1, idvar = "website", timevar = "attribute", direction = "wide") 
  upper_data[[m]]<-df1 
} 

final_data<-list()
for(i in 1:191){final_data[[i]]<-data.frame(cbind(upper_data[[i]],country=rep(links_names[i],nrow(upper_data[[i]]))))}

cols<-names(final_data[[1]])
cols<-cols[cols!="value.NA"]

for(i in 1:191){
  if(sapply(final_data,ncol)[i]==31) final_data1[[i]]<-final_data[[i]]
  if(sapply(final_data,ncol)[i]!=31){
  final_data1[[i]]<-final_data[[i]][c(1:31,length(final_data[[i]]))]
  final_data1[[i]]<-final_data1[[i]][which(names(final_data1[[i]]) %in% cols)]
  }
}

#to check out whether the data from each website is well aligned with each other (in terms of attribute name & values)
for(i in 1:191) {z[i]<-sum(names(final_data1[[1]]) %in% names(final_data1[[i]]))}
print(z)

#combining website from every country into one single data table
final_data_table<-do.call(rbind.data.frame,final_data1)
dim(final_data_table)

#check out the missing ones (sites whose data we're not able to fetch)
print(site)

#Creating a country.rank column for ranking website within country 
zrow<-integer()
for(i in 1:191){zrow[i]<-nrow(final_data1[[i]])}
country.rank<-list()
for(i in 1:191){state.rank[[i]]<-c(1:zrow[i])}
country.rank<-c(unlist(state.rank))
#length(country.rank)


