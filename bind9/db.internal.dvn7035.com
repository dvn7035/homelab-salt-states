$TTL 300
@ IN SOA whitebase.internal.dvn7035.com. dvn7035.internal.dvn7035.com. (
    2018081100 ; Serial
    86400      ; Refresh
    7200       ; Retry
    3600000    ; Expire
    172800     ; Negative Cache TTL
)

; NS records
internal.dvn7035.com. IN NS whitebase.internal.dvn7035.com.

; A records
whitebase.internal.dvn7035.com. IN A 172.27.233.1
nahelargama.internal.dvn7035.com. IN A 172.27.233.2
racailum.internal.dvn7035.com. IN A 172.27.233.3
