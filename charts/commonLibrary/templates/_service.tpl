{{- define "commonLibrary.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "commonLibrary.fullname" . }}
  labels:
    {{- include "commonLibrary.labels" . | nindent 4 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.containerPort }}
      targetPort: {{ .Values.service.targetPort}}
      protocol: TCP
      name: http
  selector:
    {{- include "commonLibrary.selectorLabels" . | nindent 4 }}
{{- end -}}
