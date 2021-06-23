# aws-infrastructure
## Build from locally
### Preconditions
* [Homebrew](https://brew.sh/index_ja.html)

### Installation
* install terraform(0.10.0 or more)

```
brew install terraform
terraform --version
> Terraform v1.0.0
```

* create s3 bucket for terraform tfstate file
```
make backend ENV=dev
```

### init

```
make remote-enable ENV=dev TARGET=proxy
make create-env ENV=dev TARGET=proxy
```

### Execution
* Check Configuretion

```
make plan ENV=dev TARGET=proxy
```

* apply

```
make apply ENV=dev TARGET=proxy
```

* destroy

```
make tf ENV=dev ARGS=plan
make destroy-plan ENV=dev TARGET=xxx
make tf ARGS=destroy ENV=dev TARGET=xxxx
```