{{/*

Copyright © 2023 - 2024. Cloud Software Group, Inc.
This file is subject to the license terms contained
in the license file that is distributed with this file.

*/}}

{{/*
    Generate certificates for hawkconsole service
*/}}

{{- define "tp-dp-hawk-console.gencerts" -}}
{{- $fullname := include "tp-dp-hawk-console.consts.appName" . }}
{{- $altNames := list ( printf "%s.%s" (include "tp-dp-hawk-console.consts.appName" .) .Release.Namespace ) ( printf "%s.%s.svc" (include "tp-dp-hawk-console.consts.appName" .) .Release.Namespace ) -}}
{{- $ca := genCA "tp-dp-hawk-console-ca" 1825 -}}
{{- $cert := genSignedCert $fullname nil $altNames 1825 $ca -}}
ca.crt: |-
{{ $ca.Cert | nindent 2 }}
tls.crt: |-
{{ $cert.Cert | nindent 2 }}
tls.key: |-
{{ $cert.Key | nindent 2 }}
{{- end -}}
