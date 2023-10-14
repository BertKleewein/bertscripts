set -e

CONTEXT=$1
if [ "${CONTEXT}" == "" ]; then
  echo Usage: >&2
  echo eval '"$(./use-local-config.sh context-name)"' >&2
  exit 1
fi

set +e
kubectl config get-contexts | grep "${CONTEXT}" > /dev/null
if [ "$?" != "0" ]; then
  echo Context ${CONTEXT} is unknown.  Valid contexts are: >&2
  kubectl config get-contexts >&2
  exit 1
fi
set +e

NEW_KUBECONFIG=${KUBECONFIG}-${CONTEXT}
echo using ${NEW_KUBECONFIG} for config >&2
cp ${KUBECONFIG} ${NEW_KUBECONFIG}

echo export KUBECONFIG=${NEW_KUBECONFIG}
echo export PS1='"('${CONTEXT}')-${debian_chroot:+($debian_chroot)}\u@\h:\w\$"'
echo kubectl config use-context ${CONTEXT}




