net user rahamath Password123 /add

net localgroup administrators /add rahamath

wmic useraccount where "name='rahamath'" set PasswordExpires=FALSE