package main

import (
	"context"
	"github.com/aws/aws-lambda-go/lambda"
	"go.uber.org/zap"
)

// Global variables are shared between lambda executions
var logger *zap.Logger

// This method will be executed before the handler
// Used to initialize global variables

func init() {
	l, _ := zap.NewProduction()
	logger = l
	defer logger.Sync()
}

// Event payload structure

type TriggerEvent struct {
	Name string `json:"name"`
}

// Lambda Handler

func LoggerHandler(ctx context.Context, e TriggerEvent) error {

	message := new(string)
	*message = "Custom message form Custom Lambda"

	logger.Info("Event Payload", zap.Stringp("Custom", message))
	return nil
}

func main() {
	lambda.Start(LoggerHandler)
}
