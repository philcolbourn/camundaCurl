#!/bin/bash

# requires: bash, curl, date, cut, cat
# optional: json_pp

# WARNING: first change TEXT_IN_UPPERASE with values for your model.
# FIXME: define these as variables

# deploy camunda model
curl 'http://localhost:8080/engine-rest/deployment/create' \
--trace-ascii q-trace.txt \
-o camunda.response \
-H 'accept: application/json' \
-F 'deployment-name=PROCESS_NAME' \
-F "deployment-source=pc-camunda-deploy-$(date | cut -d' ' -f4)" \
-F 'deploy-changed-only=false' \
-F 'PROCESS_NAME.bpmn=@PROCESS_NAME.bpmn;type=text/xml' \
-F 'FORM_NAME.html=@FORM_NAME.html;type=text/html' \
-w "\n"

# optional: display camunda response nicely
cat camunda.response | json_pp
