{{/*
Generate full resource names
*/}}
{{- define "investlab-backend.fullname" -}}
investlab-backend-{{ .Release.Name }}
{{- end }}

{{- define "investlab-backend.api.fullname" -}}
{{ include "investlab-backend.fullname" . }}
{{- end }}

{{- define "investlab-backend.worker.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-worker
{{- end }}

{{- define "investlab-backend.scheduler.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-scheduler
{{- end }}

{{- define "investlab-backend.price-stream.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-price-stream
{{- end }}

{{- define "investlab-backend.price-notifier.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-price-notifier
{{- end }}

{{- define "investlab-backend.order-engine.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-order-engine
{{- end }}

{{- define "investlab-mcp.massive.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-mcp-massive
{{- end }}

{{- define "investlab-mcp.echarts.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-mcp-echarts
{{- end }}

{{- define "investlab-backend-pvc.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-pvc
{{- end }}

{{/*
Generate standard labels for consistency
*/}}
{{- define "investlab-backend.api.labels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: api
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.worker.labels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: worker
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.scheduler.labels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: scheduler
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.price-stream.labels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: price-stream
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.price-notifier.labels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: price-notifier
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.order-engine.labels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: order-engine
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-mcp.massive.labels" -}}
app.kubernetes.io/name: investlab-mcp
app.kubernetes.io/component: massive
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-mcp.echarts.labels" -}}
app.kubernetes.io/name: investlab-mcp
app.kubernetes.io/component: echarts
app.kubernetes.io/part-of: investlab
{{- end }}

{{/*
Generate selector labels for consistency
*/}}
{{- define "investlab-backend.api.selectorLabels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: api
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.worker.selectorLabels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: worker
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.scheduler.selectorLabels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: scheduler
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.price-stream.selectorLabels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: price-stream
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.price-notifier.selectorLabels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: price-notifier
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-backend.order-engine.selectorLabels" -}}
app.kubernetes.io/name: investlab-backend
app.kubernetes.io/component: order-engine
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-mcp.massive.selectorLabels" -}}
app.kubernetes.io/name: investlab-mcp
app.kubernetes.io/component: massive
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "investlab-mcp.echarts.selectorLabels" -}}
app.kubernetes.io/name: investlab-mcp
app.kubernetes.io/component: echarts
app.kubernetes.io/part-of: investlab
{{- end }}

{{- define "postgres-cluster.fullname" -}}
postgres-cluster
{{- end }}

{{- define "postgres-cluster.namespace" -}}
postgres
{{- end }}

{{- define "postgres-cluster.namepspace" -}}
postgres
{{- end }}

{{- define "redis-cluster.fullname" -}}
redis-cluster
{{- end }}

{{- define "redis-cluster.namespace" -}}
redis
{{- end }}

{{- define "investlab-backend-secrets.fullname" -}}
{{ include "investlab-backend.api.fullname" . }}-secrets
{{- end }}