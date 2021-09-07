
# CI API Delivery

## Overview

This section will cover:

- OAS into DecK

- Plugins as YAML/JSON templates

- Shell scripts to simulate CI steps/stages

- Insomnia tests (Note: think is a link to an external repostiory due to
Insomnia limitations)

#### Pre-requsites

 1. InsoCLI: [Inso](https://insomnia.rest/products/inso)
 2. decK: [decK](https://github.com/Kong/deck)
 3. K6: [K6](https://k6.io/) (Optional if you using Perf test)

#### Usage

- Modify pipeline_script.sh to have your admin header and point to your demo workspace
- chmod 744 pipeline_script.sh
- ./ci/pipeline_script.sh

#### repository structure

Recommend following directory structure for feature team - it can be converted into Git Template

```bash
kong-api-template
├── meta
│   ├── meta.yaml
├── spec
│   ├── swagger-perstore.yaml (OAS)
├── plugins
│   ├── plugin.yaml
├── tests
│   ├── Test scripts(js)
```

- meta.yaml
  - This file sets the Kong state file to only work against any services tagged
with OAS. In reality this would be a property that reflects the API
we are working withs name

- plugins
  - In this directory Deck YAML representations of the following plugins:
e.g.
  - correlation-id for injecting a corelationID header into the request
  - key-auth for allowing keys to be created in the developer portal
  - request-transformer-advanced for inserting another header to the request
  - response-transformer-advanced for removing sensitive security headers

- tests (optional)
  - In this directory you will find a [K6 performance test script](https://k6.io/)
for generating load against the swagger petstore API to simulate a performance
test.


### Reusable deliverables:

- Shell scripts for configuring CI

- Plugin templates

