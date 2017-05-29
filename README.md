# Web-Scrapping-work
Web Scrapping webpage information for about ~10000 websites through R

### Context 

This dataset includes some of the basic information of the websites we daily use. 
While scrapping this info, I learned quite a lot in R programming, system speed, memory usage etc. and developed my niche in Web Scrapping. It took about 4-5 hrs for scrapping this data through my system (4GB RAM) and nearly about 4-5 days working out my idea through this project. 

### Content
The dataset contains Top 50 ranked sites from each 191 countries along with their traffic (global) rank. Hence country_rank defines the traffic rank of that site within the country, and traffic_rank defines the global traffic rank of that site. 

Since most of the columns meaning can be derived from their name itself, its pretty much straight forward to understand this dataset. However,  there are some instances of confusion which I would like to explain in here:

1) most of the numeric values are in character format, hence, contain spaces which you might need to clean on.

2) There are multiple instances of same website. for.e.g. Yahoo. com is present in 179 rows within this dataset. This is due to their different country rank in each country. 

3)The information provided in this dataset is for the top 50 websites in 191 countries as on 25th May 2017 and is subjected to change in future time due to the dynamic structure of ranking.

4) The dataset inactual contains 9540 rows instead of 9550(50*191 rows). This was due to the unavailability of information for 10 websites. 

PS: in case if there are anymore queries, comment on this, I'll add an answer to that in above list.

### Acknowledgements

I wouldn't have done this without the help of others. I've scrapped this information from publicly available (open to all) websites namely: 
1) http://data.danetsoft.com/ 
2) http://www.alexa.com/topsites , 
**of which i'm highly grateful**. I truly appreciate and thanks the owner of these sites for providing us with the information that I included today in this dataset.

### Inspiration

I feel that there this a lot of scope for exploring & visualization this dataset to find out the trends in the attributes of these websites across countries. Also, one could try predicting the traffic(global) rank being a dependent factor on the other attributes of the website. In any case, this dataset will help you find out the popular sites in your area.
