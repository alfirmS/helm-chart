{{- define "commonLibrary.pdb" -}}
{{- if .Values.pdb.enabled -}}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ include "commonLibrary.fullname" . }}
  namespace: {{ .Release.Namespace }}
  labels:
    {{- include "commonLibrary.labels" . | nindent 4 }}
spec:
  selector:
    matchLabels:
      {{- include "commonLibrary.selectorLabels" . | nindent 6 }}
  {{- if .Values.pdb.minAvailable }}
  minAvailable: {{ .Values.pdb.minAvailable }}
  {{- else if .Values.pdb.maxUnavailable }}
  maxUnavailable: {{ .Values.pdb.maxUnavailable }}
  {{- end }}
{{- end -}}
{{- end -}}
