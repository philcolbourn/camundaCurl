#!/bin/bash

# requires: bash, curl, date, cut, cat
# optional: json_pp

# deploy camunda model
declare PROC_NAME="pc-test-form"
declare BPMN_NAME="pc-test-form"
declare FORM_NAME="FORM-NAME"
declare    SOURCE="pc-camunda-deploy-$(date | cut -d' ' -f4)"

# deploy camunda model
curl 'http://localhost:8080/engine-rest/deployment/create' \
--write-out   "\n"                                         \
--trace-ascii  q-trace.txt                                 \
--output       camunda.response                            \
-H 'accept: application/json'                              \
-F     "deployment-name=${PROC_NAME}"                      \
-F   "deployment-source=${SOURCE}"                         \
-F 'deploy-changed-only=false'                             \
-F   "${BPMN_NAME}.bpmn=@${BPMN_NAME}.bpmn;type=text/xml"  \
-F   "${FORM_NAME}.html=@${FORM_NAME}.html;type=text/html"

# optional: display camunda response nicely
cat camunda.response | json_pp
