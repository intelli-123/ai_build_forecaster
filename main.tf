In the `google_compute_Firewall` resource `allow_http_https_1`, the `source_ranges` is currently set to `["0.0.0.0/0"]`.

To improve security, please provide a more specific CIDR range for this ingress rule instead of allowing access from all IP addresses (`0.0.0.0/0`). What specific IP ranges should be allowed to connect?