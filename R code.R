install.packages('quantmod')
install.packages('lubridate')
library(quantmod)
library(readr)
library(lubridate)
getSymbols('GOOG',from='2020-02-01', to='2020-06-01')
head(GOOG)
plot(GOOG[,'GOOG.Close'], main='GOOG')
chartSeries(GOOG)

getSymbols('ZM', src='yahoo', from='2020-02-01', to='2020-06-01')
head(ZM)
plot(ZM[,'ZM.Close'], main='ZM')
chartSeries(ZM)

getSymbols('AMZN', src='yahoo', from='2020-02-01', to='2020-06-01')
head(AMZN)
plot(AMZN[,'AMZN.Close'], main='AMZN')
chartSeries(AMZN)

getSymbols('UBER', src='yahoo', from='2020-02-01', to='2020-06-01')
head(UBER)
plot(UBER[,'UBER.Close'], main='UBER')
chartSeries(UBER)

getSymbols('TSLA', src='yahoo', from='2020-02-01', to='2020-06-01')
head(TSLA)
plot(TSLA[,'TSLA.Close'], main='TSLA')
chartSeries(TSLA)

getSymbols('TSLA', src='yahoo', from='2020-02-01', to='2020-06-01')
head(TSLA)
plot(TSLA[,'TSLA.Close'], main='TSLA')
chartSeries(TSLA)

getSymbols('MSFT', src='yahoo', from='2020-02-01', to='2020-06-01')
head(MSFT)
plot(MSFT[,'MSFT.Close'], main='MSFT')
chartSeries(MSFT)

stocks=as.xts(data.frame(GOOG[,'GOOG.Close'],ZM[,'ZM.Close'],AMZN[,'AMZN.Close'],
                         UBER[,'UBER.Close'],MSFT[,'MSFT.Close'],TSLA[,'TSLA.Close']))
head(stocks)
plot(as.zoo(stocks[,c('GOOG.Close','AMZN.Close')]),screens = 1, lty=1:2,
    xlab = 'Date', ylab = 'Price', col='blue')
par(new = TRUE)
plot(as.zoo(stocks[,c('ZM.Close','UBER.Close','MSFT.Close','TSLA.Close')]),screens = 2, lty = 1:4,
     xaxt='n', yaxt='n',xlab='', ylab ='',col=c('indianred','black'))
axis(4)
mtext('Price', side = 4, line = 6)
legend('bottomright',c('GOOG','AMZN','ZM','UBER','MSFT','TSLA'),
       inset=c(0,1),bty='n',lty=c(1,6),cex = 0.5,
       xpd=TRUE,col=c('blue','indianred','black'))


write.zoo(stocks,'stock.cvs',index.name = 'Date',sep=',')


head(global_confirmed)
global_confirmed$Date=mdy(global_confirmed$Date)
head(global_confirmed)

stock$Date=as.Date(stock$Date)

AllDates=intersect(stock$Date,global_confirmed$Date)
VecPlot=data.frame(Date=AllDates,
                   COVID=global_confirmed$NEW[match(AllDates,global_confirmed$Date)],
                   Price=stock$GOOG.Close[match(AllDates,stock$Date)])
VecPlot$Date=as.Date(VecPlot$Date,origin="1970-01-01")
head(VecPlot)
plot(VecPlot$COVID~VecPlot$Price,xlab='COVID',ylab='Price',main='GOOG')

VecPlot=data.frame(Data=AllDates,
                   COVID=global_confirmed$NEW[match(AllDates,global_confirmed$Date)],
                   Price=stock$TSLA.Close[match(AllDates,stock$Date)])
VecPlot$Date=as.Date(VecPlot$Date,origin="1970-01-01")
head(VecPlot)
plot(VecPlot$COVID~VecPlot$Price,xlab='COVID',ylab='Price',main='TSLA')

stocks=as.matrix(stocks)
head(stocks)
install.packages("RColorBrewer")
library(RColorBrewer)
install.packages("gplots")
library(gplots)
install.packages("devtools")
library(devtools)
coul=colorRampPalette(brewer.pal(11,'PiYG'))(20)
heatmap(stocks,scale = 'column',
        col=coul, cexRow = '0.3',cexCol = '0.5',
        margins = c(3,5))

