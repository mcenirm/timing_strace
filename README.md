```
cd $( TMPDIR=/dev/shm mktemp -d )
git clone -b maint https://github.com/git/git.git
$OLDPWD/timeit.sh
```
