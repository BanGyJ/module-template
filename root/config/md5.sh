#!/usr/bin/env bash
#APK 详情
#name   :	system.app-release-0411-09-45-20.apk
#MD5    :	9f903cf6b7e1e4e888c4bf82ac2f9f54
#size   :	8707882
#time   :	1501583830641
#日期    :	2017-08-01 18:37:10

size() {
  stat -c %s $1 | tr -d '\n'
}


function getdir(){
    for element in `ls $1`
    do
        dir_or_file=$1"/"$element

        if [ -d $dir_or_file ]
        then
            getdir $dir_or_file
        else
            if [ "${dir_or_file##*.}"x = "apk"x ];then
            temp_or_file="${dir_or_file%.*}.log"

            echo -e "name:\t${dir_or_file##*/}" > $temp_or_file
            echo -e "修改日期:\t$(ls --full-time --time-style=+"%Y-%m-%d %H:%M:%S" $dir_or_file | cut -d" " -f6-7 )" >> $temp_or_file
            echo -e "SIZE:\t$(size $dir_or_file)" >> $temp_or_file
            echo -e "日期:\t$(date +%Y年%m月%d日)" >> $temp_or_file
            echo -e "MD5:\t$(md5sum -t $dir_or_file|cut -d ' ' -f1)" >> $temp_or_file
            echo -e "###################################################" >> $temp_or_file
            echo -e "$(stat $dir_or_file)" >> $temp_or_file
            fi
        fi
    done

}
root_dir="../apk"
getdir $root_dir