$TTL 300

@   IN  SOA whitebase.dvn7035.com. admin.dvn7035.com. ( 
                1   ;Serial
                600 ;Refresh
                600 ;Retry
                600 ;Expire
                600 ) ;Minimum

; name servers- NS records
    IN  NS  whitebase.dvn7035.com.

; A records
whitebase.dvn7035.com.  IN  A 192.168.0.254
