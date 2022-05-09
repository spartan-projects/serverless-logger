.PHONY: build clean deploy

build:
	env GOARCH=amd64 GOOS=linux go build -ldflags="-s -w" -o bin/context context/main.go
	env GOARCH=amd64 GOOS=linux go build -ldflags="-s -w" -o bin/message message/main.go

clean:
	rm -rf ./bin deploy.zip

package: clean build
	zip -r deploy.zip bin/

deploy:
	aws lambda update-function-code --profile dmi-training --function-name arn:aws:lambda:us-east-1:116979089277:function:dev-sls-message --zip-file fileb://deploy.zip
	aws lambda update-function-code --profile dmi-training --function-name arn:aws:lambda:us-east-1:116979089277:function:dev-sls-context --zip-file fileb://deploy.zip

awsContext:
	aws lambda invoke --profile dmi-training --function-name arn:aws:lambda:us-east-1:116979089277:function:dev-sls-context output.json

awsMessage:
	aws lambda invoke --profile dmi-training --function-name arn:aws:lambda:us-east-1:116979089277:function:dev-sls-message output.json