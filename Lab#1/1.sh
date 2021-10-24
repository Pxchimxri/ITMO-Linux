#!/bin/sh
#1
cd ~
mkdir test

#2
ls -aF /etc >> ~/test/list

#3
find /etc -type d | wc -l >> ~/test/list
find /etc -maxdepth 1 -name '.*' | wc -l >> ~/test/list

#4
mkdir ~/test/links

#5
cd ~/test/links
ln ../list list_hlink

#6
ln -s ../list list_slink

#7
ls -l ~/test/links/list_hlink | awk '{print $2}'
ls -l ~/test/list | awk '{print $2}'
ls -l ~/test/links/list_slink | awk '{print $2}'

#8
cat ../list | wc -l >> list_hlink

#9
cmp -s list_hlink list_slink && echo "9 - YES"

#10
cd ..
mv list list1

#11
cd links
cmp -s list_hlink list_slink && echo "11 - YES"

#12
cd ~
ln -d ~/test/links links_link
ln ~/test/list1 list_link

#13
find /etc -name '*.conf' > list_conf

#14
find /etc -maxdepth 1 -name '*.d' > list_d

#15
cat list_conf > list_conf_d
cat list_d >> list_conf_d

#16
cd ~/test
mkdir .sub

#17
cd .sub
cp ~/list_conf_d ~/test/.sub

#18
cp -b ~/list_conf_d ~/test/.sub

#19
find ~/test -print

#20
cd ~
man man >> man.txt

#21
split man.txt -b 1K

#22
mkdir ~/test/man.dir

#23
mv x** ~/test/man.dir

#24
cd ~/test/man.dir
cat x** > ~/test/man.dir/man.txt

#25
cmp -s man.txt ~/test/man.dir/man.txt && echo "25 - YES"

#26
cd ~
sed -i '1s/^/Hello\nWorld\n/' man.txt
echo -e "Bye\nWorld" >> man.txt

#27
diff -u ~/test/man.dir/man.txt man.txt > diff.diff

#28
mv diff.diff ~/test/man.dir

#29
cd ~/test/man.dir
patch  man.txt  diff.diff

#30
cmp -s ~/man.txt ~/test/man.dir/man.txt && echo "30 - YES"