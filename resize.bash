smartresize() {
  full_file_name=$1
  extension="${full_file_name##*.}"
  filename="${full_file_name%.*}"
  # echo "${filename}-$2.${extension}"
  mogrify -write ${filename}-$2.${extension} -filter Triangle -define filter:support=2 -thumbnail $2 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}

# Added in master...

pinukResize(){
  uniq_file_name=$1
  extension="${uniq_file_name##*.}"
  filename="${uniq_file_name%.*}"
  srcset_string=""
  shift
  for var in "$@"
  do
    smartresize ${uniq_file_name} ${var}
    srcset_string+="${filename}-${var}.${extension} ${var}w, "
  done
  # echo "<img src=\"$uniq_file_name\" srcset=\"flower-small.jpg 480w, flower-large.jpg 1080w\" sizes=\"50vw\">"
  echo "<img src=\"$uniq_file_name\" srcset=\"${srcset_string:0:-2}\" sizes=\"50vw\">"
}
