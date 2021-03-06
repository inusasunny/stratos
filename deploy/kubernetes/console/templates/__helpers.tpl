{{/* vim: set filetype=mustache: */}}
{{/*
Image pull secret
*/}}
{{- define "imagePullSecret" }}
{{- printf "{\"%s\":{\"username\": \"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\": \"%s\"}}" .Values.kube.registry.hostname .Values.kube.registry.username .Values.kube.registry.password .Values.kube.registry.email (printf "%s:%s" .Values.kube.registry.username .Values.kube.registry.password | b64enc) | b64enc }}
{{- end }}


{{/*
Determine external IPs:
This will do the following:
1. Check for Legacy SCF Config format
2. Check for Console specific External IP
3. Check for New SCF Config format
4. Check for new Console External IPS
*/}}
{{- define "service.externalIPs" -}}
{{- if .Values.kube.external_ip -}}
{{- printf "\n - %s" .Values.kube.external_ip | indent 3 -}}
{{- else if .Values.console.externalIP -}}
{{- printf "\n - %s" .Values.console.externalIP | indent 3 -}}
{{- else if .Values.kube.external_ips -}}
{{- range .Values.kube.external_ips -}}
{{ printf "\n- %s" . | indent 4 -}}
{{- end -}}
{{- else if .Values.console.service.externalIPs -}}
{{- range .Values.console.service.externalIPs -}}
{{ printf "\n- %s" . | indent 4 -}}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Get SCf UAA Endpoint
*/}}
{{- define "scfUaaEndpoint" -}}
{{- if and .Values.env.DOMAIN (not .Values.env.UAA_HOST) -}}
{{- printf "https://scf.uaa.%s:%v" .Values.env.DOMAIN .Values.env.UAA_PORT -}}
{{- else if .Values.env.UAA_HOST -}}
{{- printf "https://scf.%s:%v" .Values.env.UAA_HOST .Values.env.UAA_PORT -}}
{{- end -}}
{{- end -}}


{{/*
Service type:
*/}}
{{- define "service.serviceType" -}}
{{- if or .Values.useLb .Values.services.loadbalanced -}}
LoadBalancer
{{- else -}}
{{- printf "%s" .Values.console.service.type -}}
{{- end -}}
{{- end -}}


{{/*
Service port:
*/}}
{{- define "service.servicePort" -}}
{{- if and .Values.kube.external_ips .Values.kube.external_console_https_port -}}
{{ printf "%v" .Values.kube.external_console_https_port }}
{{- else -}}
{{ .Values.console.service.servicePort }}
{{- end -}}
{{- end -}}
