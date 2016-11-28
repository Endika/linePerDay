package main

import (
	"fmt"
	"gopkg.in/gomail.v2"
	"io/ioutil"
	"net/http"
	"os"
)

// Config area
const SMTP string = "smtp.server.com"
const PORT int = 587
const USER string = "user_server"
const PASS string = "password_server"
const FROM string = "user@my_host.com"
const TO string = "user2@gmail.com"
const SUBJECT string = "Theorem Of The Day"

const URL string = "http://www.theoremoftheday.org/todays.php"
const FILENAME string = "TheoremOfTheDay.pdf"

func sendMail(text string) {
	m := gomail.NewMessage()
	m.SetHeader("From", FROM)
	m.SetHeader("To", TO)
	m.SetHeader("Subject", SUBJECT)
	m.SetBody("text/html", text)
	m.Attach(FILENAME)

	d := gomail.NewDialer(SMTP, PORT, USER, PASS)

	if err := d.DialAndSend(m); err != nil {
		panic(err)
	}
}

func main() {
	res, err := http.Get(URL)
	if err != nil {
		panic(err)
	}
	content, err := ioutil.ReadAll(res.Body)
	res.Body.Close()
	if err != nil {
		panic(err)
	}
	f, err := os.Create(FILENAME)
	if err != nil {
		panic(err)

	}
	byteSlice := []byte(content)
	n, err := f.Write(byteSlice)
	if err != nil {
		panic(err)
	}
	fmt.Printf("wrote %d bytes\n", n)
	sendMail("Hi, look at today's theorem.")
	err = os.Remove(FILENAME)
	if err != nil {
		panic(err)
	}
}
