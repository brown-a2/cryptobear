#!/bin/sh
# Decrypt archived files. Take encrypted files and unzip.

cat <<'EOF'

  /$$$$$$  /$$$$$$$  /$$     /$$ /$$$$$$$  /$$$$$$$$ /$$$$$$
 /$$__  $$| $$__  $$|  $$   /$$/| $$__  $$|__  $$__//$$__  $$
| $$  \__/| $$  \ $$ \  $$ /$$/ | $$  \ $$   | $$  | $$  \ $$
| $$      | $$$$$$$/  \  $$$$/  | $$$$$$$/   | $$  | $$  | $$
| $$      | $$__  $$   \  $$/   | $$____/    | $$  | $$  | $$
| $$    $$| $$  \ $$    | $$    | $$         | $$  | $$  | $$
|  $$$$$$/| $$  | $$    | $$    | $$         | $$  |  $$$$$$/
 \______/ |__/  |__/    |__/    |__/         |__/   \______/
 /$$$$$$$  /$$$$$$$$  /$$$$$$  /$$$$$$$
| $$__  $$| $$_____/ /$$__  $$| $$__  $$
| $$  \ $$| $$      | $$  \ $$| $$  \ $$
| $$$$$$$ | $$$$$   | $$$$$$$$| $$$$$$$/
| $$__  $$| $$__/   | $$__  $$| $$__  $$
| $$  \ $$| $$      | $$  | $$| $$  \ $$
| $$$$$$$/| $$$$$$$$| $$  | $$| $$  | $$
|_______/ |________/|__/  |__/|__/  |__/

ENCRYPT / DECRYPT FILES

EOF

RESTORE='\033[0m'
YELLOW='\033[00;33m'
GREEN='\033[00;32m'

function msg {
  echo "$1"$RESTORE
}

# Common vars
hash=''YOUR PASSWORD HERE''
basedir="crypt/"
encrypted_file_dir="${basedir}decrypt/"
decrypted_file_dir="${basedir}encrypt/"
query="Encrypt or Decrypt? (e/d) "

# Env params
echo "** ENV SETUP **"
echo "Encryption paths: "
msg $GREEN$encrypted_file_dir
msg $GREEN$decrypted_file_dir

if [ -z ${hash+x} ]; then
  msg $YELLOW"No hash available to encrypt/decrypt, pls add.";
else
  msg $GREEN"Hash loaded."
fi
msg $GREEN"Using OPENSSL AES 256 CBC encryption"
echo ""

# Start program
msg "$GREEN$query"
read -r requested_action

if [[ "$requested_action" = "d" ]]; then

# DECRYPT FILES
function decrypt {

  cd $encrypted_file_dir

    for file in *
    do
      msg $GREEN"Decrypting file ${file}:"
      openssl aes-256-cbc -d -in $file -out ${file}.zip -pass pass:$hash
      echo ${file}.zip
      msg $GREEN"Unzipping file into folder:"
      rm $file
      unzip ${file}.zip
      msg $GREEN"Removing .zip file"
      rm ${file}.zip
    done

  msg $GREEN"Done."

}

decrypt

elif [[ "$requested_action" = "e" ]]; then

# ENCRYPT FILES
function encrypt {

  cd $decrypted_file_dir

  # remove file spaces with dashes
  for file in *
  do
    mv "$file" "${file// /-}"
  done

  # lowercase all file characters
  for file in *
  do
    lc=`echo "$file" | tr '[:upper:]' '[:lower:]'`
    mv -f $file $lc
  done

  for file in *
    do
      msg $GREEN"Compressing ${file} into .zip:"
      zip -r ${file}.zip $file
      rm -rf $file
      msg $GREEN"Encrypting file ${file}: "
      openssl aes-256-cbc -in ${file}.zip -out ${file} -pass pass:$hash
      msg $GREEN"Removed .zip"
      rm ${file}.zip
    done

  msg $GREEN"Done."

}

encrypt

else
  msg $YELLOW"Oops, seems like a typo? Pls type either 'encrypt' or 'decrypt' or crypto bear will eat you."
  echo "Bye!"
fi

exit 0
