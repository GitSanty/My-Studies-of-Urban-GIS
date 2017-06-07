# Name: The relationship between AQI and Search Index
# Purpose: Generation ,visualization and analysis
# Author:      Dai shaoqing
#
# Created:     06/07/2017
# Copyright:   (c) Dai shaoqing <dsq1993qingge@163.com> 2017
#------------------------------------------------------------
#��ȡ����
aqi<-read.csv("F:/R/test/multiplot/data/wm1new.csv",header = T)

#�������ڸ�ʽ
xlabel<-aqi$date
d<-as.character(xlabel)
days1<-matrix(unlist(strsplit(d,split="��")),ncol=2,byrow=T)
days2<-matrix(unlist(strsplit(days1[,2],split="��")),ncol=1,byrow=T)
date<-paste("2017",days1[,1],days2,sep="-")
date<-as.Date(date,"%Y-%m-%d")

#����AQIϵ��ͼ
jpeg("F:/R/test/multiplot/output/plot.jpg",width = 20,height = 16,units = "in",res = 300)
par(fig=c(0,0.95,0,1))
plot(aqi$AQI,xlab="Date",ylab="AQI",type="l",xaxt="n",col='red')
axis(side=1,at=1:61,labels = date)

#���õ�����ͼ
par(new=T)

#���Ʊ�����������������ָ��ϵ��ͼ
plot(aqi$bjwm,type="l",xlab="Date",ylab="",ylim=c(500,8000),xaxt="n",yaxt="n",col="blue")
par(new=T)
plot(aqi$wm,type="l",xlab="Date",ylab="",ylim=c(500,8000),xaxt="n",yaxt="n",col="green")

#����˫������ͼ��y��̶ȱ�ǩ
y1label<-c(1600,3200,4800,6400,8000)
y2label<-c(1600,3200,4800,6400,8000)
axis(side=4,at=y1label,labels=y2label)
mtext("����ָ��",side=4,line=2,padj=1)
legend("topleft",legend=c("AQI","������������ָ��","��������ָ��"), lwd=1, col=c("red", "blue","green"))
dev.off()

#����AQI������ָ���Ļع鷽���Լ������Լ���
plot(aqi[,2:4],pch=16,col="red")

aqi.bjwm<-lm(AQI~bjwm,data=aqi)
summary(aqi.bjwm)

aqi.wm<-lm(AQI~wm,data=aqi)
summary(aqi.wm)

aqi.model<-lm(AQI~bjwm+wm,data=aqi)
summary(aqi.model)

#�ع������ӻ�
layout(matrix(c(1,2,3,4),nrow=2,byrow=T))
plot(aqi.bjwm)
plot(aqi.wm)
plot(aqi.model)