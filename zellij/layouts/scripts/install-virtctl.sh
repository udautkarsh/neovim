sudo sh -c 'VERSION=$(curl -fsSL https://storage.googleapis.com/kubevirt-prow/release/kubevirt/kubevirt/stable.txt) \
 && wget -qO /usr/local/bin/virtctl "https://github.com/kubevirt/kubevirt/releases/download/${VERSION}/virtctl-${VERSION}-linux-amd64" \
 && chmod +x /usr/local/bin/virtctl'

