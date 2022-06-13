{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "pearl.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "pearl.ui.name" -}}
{{- printf "%s-%s" (include "pearl.name" .) .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "pearl.api.name" -}}
{{- printf "%s-%s" (include "pearl.name" .) .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pearl.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "pearl.ui.fullname" -}}
{{- printf "%s-%s" (include "pearl.fullname" .) .Values.ui.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{- define "pearl.api.fullname" -}}
{{- printf "%s-%s" (include "pearl.fullname" .) .Values.api.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pearl.chart" -}}
{{- printf "pearl" -}}
{{- end -}}

{{- define "pearl.api.chart" -}}
{{- printf "pearl-api" -}}
{{- end -}}

{{- define "pearl.ui.chart" -}}
{{- printf "pearl-ui" -}}
{{- end -}}


{{/*Common labels*/}}

{{- define "pearl.labels" -}}
helm.sh/chart: {{ include "pearl.chart" . }}
{{ include "pearl.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "pearl.api.labels" -}}
helm.sh/chart: {{ include "pearl.api.chart" . }}
{{ include "pearl.api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "pearl.ui.labels" -}}
helm.sh/chart: {{ include "pearl.ui.chart" . }}
{{ include "pearl.ui.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*Selector labels*/}}
{{- define "pearl.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pearl.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}


{{- define "pearl.api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pearl.api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{- define "pearl.ui.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pearl.ui.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*Create the name of the service account to use*/}}

{{- define "pearl.api.serviceAccountName" -}}
{{- if .Values.api.serviceAccount.create -}}
    {{ default (include "pearl.api.fullname" .) .Values.api.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.api.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{- define "pearl.ui.serviceAccountName" -}}
{{- if .Values.ui.serviceAccount.create -}}
    {{ default (include "pearl.ui.fullname" .) .Values.ui.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.ui.serviceAccount.name }}
{{- end -}}
{{- end -}}