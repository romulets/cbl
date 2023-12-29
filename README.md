# cbl
A quick local env management for [elastic/cloudbeat](https://github.com/elastic/cloudbeat)

## Commands 

build
```bash
./cbl build
```

run
```bash
./cbl run
```

run with specific debug logger enabled
build
```bash
./cbl run posture
```

build and run
```bash
./cbl br
```

build and run with specific debug logger enabled
```bash
./cbl br posture
```


configure cloudbeat.yml (available `aws`, `gcp`, `azure`)
```bash
./cbl conf aws
```

clean cloudbeat.yml
```bash
./cbl clean
```