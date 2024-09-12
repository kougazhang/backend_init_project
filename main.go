package main

import (
	"nexus/internal/handlers"
	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
)

var logger *log.Logger

func init() {
	logger = log.New()
	logger.SetLevel(log.InfoLevel)
}

func main() {
	r := gin.Default()
	v1 := r.Group("/api/v1")
	{
		v1.GET("/ping", handlers.Ping)
	}

	r.Run(":8080")
}
