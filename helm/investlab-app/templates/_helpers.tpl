{{- define "investlab-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "investlab-app.fullname" -}}
{{- .Values.fullnameOverride | default (printf "%s-%s" .Release.Name .Chart.Name) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "investlab-app.backendImage" -}}
{{- printf "%s/%s:%s" .Values.backend.image.registry .Values.backend.image.repository (.Values.backend.image.tag | default .Chart.AppVersion) }}
{{- end }}

{{- define "investlab-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "investlab-app.labels" -}}
helm.sh/chart: {{ include "investlab-app.chart" . }}
{{ include "investlab-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "investlab-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "investlab-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "investlab-app.serviceAccountName" -}}
{{- .Values.serviceAccount.name | default (include "investlab-app.fullname" .) }}
{{- end }}

{{- define "investlab-app.backendEnvVars" -}}
- name: REDIS_URL
  value: "redis://{{ .Values.env.redis.host }}:{{ .Values.env.redis.port }}"
- name: DJANGO_LOG_LEVEL
  value: {{ .Values.env.django.logLevel | quote }}
- name: DEBUG
  value: {{ .Values.env.django.debug | quote }}
- name: SECRET_KEY
  value: {{ .Values.env.django.secretKey | quote }}
- name: ALLOWED_HOSTS
  value: {{ .Values.env.django.allowedHosts | quote }}
- name: DATABASE_URL
  value: {{ .Values.env.database.url | quote }}
- name: POSTGRES_HOST
  value: {{ .Values.env.database.host | quote }}
- name: POSTGRES_PORT
  value: {{ .Values.env.database.port | quote }}
- name: POSTGRES_DB
  value: {{ .Values.env.database.name | quote }}
- name: POSTGRES_USER
  value: {{ .Values.env.database.user | quote }}
- name: POSTGRES_PASSWORD
  value: {{ .Values.env.database.password | quote }}
- name: REDIS_HOST
  value: {{ .Values.env.redis.host | quote }}
- name: REDIS_PORT
  value: {{ .Values.env.redis.port | quote }}
- name: REDIS_PASSWORD
  value: {{ .Values.env.redis.password | quote }}
- name: CORS_ALLOWED_ORIGINS
  value: {{ .Values.env.cors.allowedOrigins | quote }}
- name: CSRF_TRUSTED_ORIGINS
  value: {{ .Values.env.cors.csrfTrustedOrigins | quote }}
- name: CLERK_SECRET_KEY
  value: {{ .Values.env.clerk.secretKey | quote }}
- name: CLERK_ISSUER
  value: {{ .Values.env.clerk.issuer | quote }}
- name: CLERK_JWKS_URL
  value: {{ .Values.env.clerk.jwksUrl | quote }}
- name: CLERK_JWT_KEY
  value: {{ .Values.env.clerk.jwtKey | quote }}
- name: POLYGON_SECRET_KEY
  value: {{ .Values.env.apis.polygonSecretKey | quote }}
- name: ALPACA_PUBLIC_KEY
  value: {{ .Values.env.apis.alpacaPublicKey | quote }}
- name: ALPACA_SECRET_KEY
  value: {{ .Values.env.apis.alpacaSecretKey | quote }}
- name: ADMIN_EMAIL
  value: {{ .Values.env.email.adminEmail | quote }}
- name: FROM_EMAIL
  value: {{ .Values.env.email.fromEmail | quote }}
- name: EMAIL_BACKEND
  value: {{ .Values.env.email.backend | quote }}
- name: EMAIL_FILE_PATH
  value: {{ .Values.env.email.filePath | quote }}
- name: VAPID_PRIVATE_KEY
  value: {{ .Values.env.vapid.privateKey | quote }}
- name: VAPID_PUBLIC_KEY
  value: {{ .Values.env.vapid.publicKey | quote }}
{{- end }}
