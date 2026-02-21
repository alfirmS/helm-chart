{{- define "commonLibrary.hpa" -}}
{{- if .Values.hpa.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "commonLibrary.fullname" . }}
  labels:
    {{- include "commonLibrary.labels" . | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "commonLibrary.fullname" . }}
  minReplicas: {{ .Values.hpa.minReplicas }}
  maxReplicas: {{ .Values.hpa.maxReplicas }}
  metrics:
    {{- toYaml .Values.hpa.metrics | nindent 4 }}
  behavior:
    {{- toYaml .Values.hpa.behavior | nindent 4 }}
{{- end }}
{{- end -}}
