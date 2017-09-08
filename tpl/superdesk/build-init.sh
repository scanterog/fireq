locale-gen en_US.UTF-8

apt-get update
apt-get -y install --no-install-recommends \
git python3 python3-dev python3-venv \
build-essential libffi-dev \
libtiff5-dev libjpeg8-dev zlib1g-dev \
libfreetype6-dev liblcms2-dev libwebp-dev \
curl libfontconfig libssl-dev \
libxml2-dev libxslt1-dev \
libxmlsec1-dev

{{>add-node.sh}}

## virtualenv and activate script
env={{repo_env}}
[ -d $env ] && rm -rf $env
python3 -m venv $env
unset env

cat <<"EOF" > {{activate}}
. {{repo_env}}/bin/activate

set -a
# some settings required by client
PATH={{repo_client}}/node_modules/.bin/:$PATH
SUPERDESK_URL='http://localhost/api'
SUPERDESK_WS_URL='ws://localhost/ws'
set +a
EOF
{{#develop}}
cat <<EOF > /etc/profile.d/activate.sh
[ -f {{activate}} ] && . {{activate}}
EOF
{{/develop}}

_activate
pip install -U pip wheel