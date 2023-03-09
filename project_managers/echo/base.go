package main

import (
	"fmt"
	"net/http"

	// echo: https://echo.labstack.com/guide
	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	echoWebSite := "https://echo.labstack.com/"
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, fmt.Sprintf("Started echo service, bring it on! See %s", echoWebSite))
	})
	e.Logger.Fatal(e.Start(":1323"))
}
