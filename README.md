# Description
Letsencrypt keeps an archive of expired certificates in the "archive" directory forever. Only the latest files are actually used, by being symlinked from the "live" directory.

```
.~# ls -l /etc/letsencrypt/live/example.com/
total 4
-rw-r--r-- 1 root root 692 Jan 27  2022 README
lrwxrwxrwx 1 root root  37 Jan 13 03:46 cert.pem -> ../../archive/example.com/cert23.pem
lrwxrwxrwx 1 root root  38 Jan 13 03:46 chain.pem -> ../../archive/example.com/chain23.pem
lrwxrwxrwx 1 root root  42 Jan 13 03:46 fullchain.pem -> ../../archive/example.com/fullchain23.pem
lrwxrwxrwx 1 root root  40 Jan 13 03:46 privkey.pem -> ../../archive/example.com/privkey23.pem
```

If you are managing a large number of certificates, the "archive" directory can grow in size over time, and since these files are small, there is a good chance that you'll also run out of available inodes before running out of available disk space.

This script deletes expired certificates from the "archive" directory and leaves only the active ones which are symlinked from the "live" directory. 

# Usage

```
./cleanup_letsencrypt_archive.sh deleteall
```

Ideally, cleanup should be automated through cron job (for example, once every month).