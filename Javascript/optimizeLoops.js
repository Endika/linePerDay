var total = 10;

for(var i=total; i--;){
    console.log("for => DESC mode " + i);
    console.log("for => ASC mode " + total-i-1);
}

var i = total;
while(i--){
    console.log("while => DESC mode " + i);
    console.log("while => ASC mode " + total-i-1);
}
