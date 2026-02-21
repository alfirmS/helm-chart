{{- define "commonLibrary.externalSecret" -}}
{{- if .Values.externalSecret.enabled -}}
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: {{ include "commonLibrary.fullname" . }}
  labels:
    {{- include "commonLibrary.labels" . | nindent 4 }}
spec:
  refreshInterval: {{ .Values.externalSecret.refreshInterval }}
  secretStoreRef:
    name: {{ include "commonLibrary.es.secretStoreName" . }}
    kind: SecretStore
  target:
    name: {{ include "commonLibrary.es.targetName" . }}
  dataFrom:
  - extract:
      key: {{ include "commonLibrary.fullname" . }}
{{- end }}
{{- end -}}
