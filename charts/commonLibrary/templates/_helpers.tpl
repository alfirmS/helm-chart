{{/*
Expand the name of the chart.
*/}}
{{- define "commonLibrary.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Nama stable (tanpa suffix) — digunakan oleh Canary Ingress
untuk merujuk ke stable Service.
*/}}
{{- define "common.stableName" -}}
{{- if .Values.fullnameOverride -}}
  {{- .Values.fullnameOverride | trunc 55 | trimSuffix "-" -}}
{{- else -}}
  {{- $name := default .Chart.Name .Values.nameOverride -}}
  {{- printf "%s-%s" .Release.Name $name | trunc 55 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "commonLibrary.fullname" -}}
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
{{- define "commonLibrary.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "commonLibrary.labels" -}}
helm.sh/chart: {{ include "commonLibrary.chart" . }}
{{ include "commonLibrary.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Values.image.tag | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "commonLibrary.selectorLabels" -}}
app.kubernetes.io/name: {{ include "commonLibrary.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "commonLibrary.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "commonLibrary.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name external secret store name
*/}}
{{- define "commonLibrary.es.secretStoreName" -}}
{{- printf "secret-store-%s" .Values.global.env -}}
{{- end -}}

{{/*
Create the name external secret target name
*/}}
{{- define "commonLibrary.es.targetName" -}}
{{- printf "%s-%s" .Values.global.env (include "commonLibrary.fullname" .) -}}
{{- end -}}
