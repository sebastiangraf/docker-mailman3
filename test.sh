export DOCKERMAIL_OPENDKIM_PORT_8891_TCP_ADDR=172.17.0.10
# re=^.*PORT_8891_TCP_ADDR=(.*)$
# echo "$( printenv | sed 's||1|' )"
#
if [[ $(printenv) =~ ^.*PORT_8891_TCP_ADDR=([0-9\.]*) ]] ; then
  echo "${BASH_REMATCH[1]}"
  echo "====================="
fi
