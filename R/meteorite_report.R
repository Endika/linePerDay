library(jsonlite)
library(maps)
library(mailR)

coor <- list(x=1,y=1,year=1)
data <- fromJSON("https://data.nasa.gov/resource/y77d-th95.json")
for (i in 1:length(data$geolocation$coordinates)){
    coor$x <- c(coor$x, data$geolocation$coordinates[[i]][1] )
    coor$y <- c(coor$y, data$geolocation$coordinates[[i]][2] )
    coor$year <- c(coor$year, data$year[i] )
}

coor_ten <- list(x=1,y=1,year=1)
coor_ten$x <- coor$x[coor$year >= as.integer(format(Sys.Date(), "%Y"))-10]
coor_ten$y <- coor$y[coor$year >= as.integer(format(Sys.Date(), "%Y"))-10]

coor_current <- list(x=1,y=1,year=1)
coor_current$x <- coor$x[coor$year >= as.integer(format(Sys.Date(), "%Y"))]
coor_current$y <- coor$y[coor$year >= as.integer(format(Sys.Date(), "%Y"))]

png("world.png")
map("world", fill=TRUE, col="white",
    bg="lightblue", ylim=c(-60, 90), mar=c(0,0,0,0))
points(coor$x, coor$y, col="green", pch=18)
points(coor_ten$x, coor_ten$y, col="orange", pch=16)
points(coor_current$x, coor_current$y, col="red", pch=19)
dev.off()

png("spain.png")
map("world", "Spain", fill=TRUE, col="white", bg="lightblue")
points(coor$x, coor$y, col="green", pch=18)
points(coor_ten$x, coor_ten$y, col="orange", pch=19)
points(coor_current$x, coor_current$y, col="red", pch=16)
dev.off()

send.mail(
    from="from@gmail.com",
    to=c("to@gmail.com"),
    subject="Report Meteorite Landings",
    body="See the dailing repor.\nGREEN more 10 years\nORANGE during 10 years\nRED current year.",
    smtp=list(
        host.name="smtp.server.com",
        port=587,
        user.name="USERNAME",
        passwd="password",
        ssl=FALSE),
    authenticate=TRUE,
    send=TRUE,
    attach.files=c("world.png", "spain.png"),
    debug=FALSE)
file.remove(c("world.png", "spain.png"))
