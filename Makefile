BASE := $(shell pwd)
SRCS := $(BASE)/main.go
EXE := $(BASE)/bin/nexus

build:
	@go mod download
	@GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags="-s -w" -o nexus ./main.go

rpmbuild:
	@echo "building nexus ..."
	@go mod download
	@$(GOROOT)/bin/go build -o $(EXE) $(SRCS)
	@echo  "rpm build ..."
	@cd $(BASE)/sbin && sh rpm-tools.sh -a
	@cd $(BASE)
	@rm $(EXE)

clean:
	rm $(EXE)