# Step#1 - Parse the input
eval "$(jq -r '@sh "token=\(.token)"')"

# Step#2 - Parse json
rebrain_ssh_fingerprint=`curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $token" "https://api.digitalocean.com/v2/account/keys?per_page=200" \
    | jq -r '.ssh_keys[] | select(.name=="REBRAIN.SSH.PUB.KEY") | .fingerprint'`

# Step#3 - Create a JSON object and pass it back
jq -n -r --arg rebrain_ssh_fingerprint "$rebrain_ssh_fingerprint" '{"fingerprint":$rebrain_ssh_fingerprint}'