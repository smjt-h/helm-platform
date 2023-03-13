{{- define "harnesssecrets.generateSecrets" }}
{{- $timescaledbAdminPassword := include "common.secrets.passwords.manage" (dict "secret" "harness-secrets" "key" "timescaledbAdminPassword" "providedValues" (list "timescaledb.adminPassword") "length" 16 "context" $) }}
{{- $timescaledbPostgresPassword := include "common.secrets.passwords.manage" (dict "secret" "harness-secrets" "key" "timescaledbPostgresPassword" "providedValues" (list "timescaledb.postgresPassword") "length" 16 "context" $) }}
{{- $timescaledbStandbyPassword := include "common.secrets.passwords.manage" (dict "secret" "harness-secrets" "key" "timescaledbStandbyPassword" "providedValues" (list "timescaledb.standbyPassword") "length" 16  "context" $) }}
    mongodbUsername: YWRtaW4=
    mongodbPassword: {{ include "common.secrets.passwords.manage" (dict "secret" "harness-secrets" "key" "mongodbPassword" "providedValues" (list "mongodb.password") "length" 16 "context" $) }}
    postgresdbAdminPassword: {{ include "common.secrets.passwords.manage" (dict "secret" "harness-secrets" "key" "postgresdbAdminPassword" "providedValues" (list "postgresdb.adminPassword") "length" 16 "context" $) }}
    stoAppHarnessToken:  {{ include "common.secrets.passwords.manage" (dict "secret" "harness-secrets" "key" "stoAppHarnessToken" "providedValues" (list "sto.appHarnessToken") "length" 16 "context" $) }}
    stoAppAuditJWTSecret:  {{ include "common.secrets.passwords.manage" (dict "secret" "harness-secrets" "key" "stoAppAuditJWTSecret" "providedValues" (list "sto.appAuditJWTSecret") "length" 16 "context" $) }}
    timescaledbAdminPassword: {{ $timescaledbAdminPassword }}
    timescaledbPostgresPassword: {{ $timescaledbPostgresPassword }}
    timescaledbStandbyPassword:  {{ $timescaledbStandbyPassword }}
    PATRONI_SUPERUSER_PASSWORD: {{ $timescaledbPostgresPassword }}
    PATRONI_REPLICATION_PASSWORD: {{ $timescaledbStandbyPassword }}
    PATRONI_admin_PASSWORD: {{ $timescaledbAdminPassword }}
{{- end }}

{{- define "harnesssecrets.generateMinioSecrets" }}
    root-user: {{ include "common.secrets.passwords.manage" (dict "secret" "minio" "key" "root-user" "providedValues" (list "minio.rootUser") "length" 10 "context" $) }}
    root-password: {{ include "common.secrets.passwords.manage" (dict "secret" "minio" "key" "root-password" "providedValues" (list "minio.rootPassword") "length" 10 "context" $) }}
{{- end }}

{{- define "harnesssecrets.generateMinioSecretsAgain" }}
{{- if .Values.minio.rootUser }}
root-user: {{ .Values.minio.rootUser | b64enc | quote }}
{{- else}}
root-user: {{ randAlphaNum 10 | quote }}
{{- end -}}
{{- if .Values.minio.rootPassword }}
root-password: {{ .Values.minio.rootPassword }}
{{- else}}
root-password: {{ randAlphaNum 10 | quote }}
{{- end -}}
{{- end }}

{{- define "getDefaultOrRandom" }}
{{- if .Default }}
{{- printf "%s" .Default}}
{{- else }}
{{- randAlphaNum .Length}}
{{- end}}
{{- end }}
