{{/*
Expand the name of the chart.
*/}}
{{- define "azure-vote.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "azure-vote.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "azure-vote.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "azure-vote.labels" -}}
helm.sh/chart: {{ include "azure-vote.chart" . }}
{{ include "azure-vote.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels for vote back
*/}}
{{- define "azure-vote.back.labels" -}}
helm.sh/chart: {{ include "azure-vote.chart" . }}
{{ include "azure-vote.back.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for vote back
*/}}
{{- define "azure-vote.back.selectorLabels" -}}
app.kubernetes.io/name: {{ include "azure-vote.name" . }}-back
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels for vote front
*/}}
{{- define "azure-vote.front.labels" -}}
helm.sh/chart: {{ include "azure-vote.chart" . }}
{{ include "azure-vote.front.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for vote front
*/}}
{{- define "azure-vote.front.selectorLabels" -}}
app.kubernetes.io/name: {{ include "azure-vote.name" . }}-front
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "azure-vote.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "azure-vote.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
