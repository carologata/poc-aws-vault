
# vault binary
sudo curl --silent -Lo /tmp/vault.zip https://releases.hashicorp.com/vault/1.18.3/vault_1.18.3_linux_amd64.zip
cd /tmp
sudo unzip vault.zip
sudo mv vault /usr/local/bin
cd ..

# vault service 
cd /etc/systemd/system
echo <<EOF > vault.service
[Unit]
Description="HashiCorp Vault - A tool for managing secrets"
Documentation=https://www.vaultproject.io/docs/
Requires=network-online.target
After=network-online.target
ConditionFileNotEmpty=/etc/vault.d/vault.hcl
StartLimitIntervalSec=60
StartLimitBurst=3

[Service]
User=vault
Group=vault
ProtectSystem=full
ProtectHome=read-only
PrivateTmp=yes
PrivateDevices=yes
SecureBits=keep-caps
AmbientCapabilities=CAP_IPC_LOCK
Capabilities=CAP_IPC_LOCK+ep
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
NoNewPrivileges=yes
ExecStart=/usr/local/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill --signal HUP $MAINPID
KillMode=process
KillSignal=SIGINT
Restart=on-failure
RestartSec=5
TimeoutStopSec=30
StartLimitInterval=60
StartLimitIntervalSec=60
StartLimitBurst=3
LimitNOFILE=65536
LimitMEMLOCK=infinity

[Install]
WantedBy=multi-user.target
EOF

# vault hcl 
cd ../../..
cd /etc/vault.d
echo <<EOF > vault.hcl

# config file

EOF

# create user vault and group vault

sudo systemctl start vault


# https://releases.hashicorp.com/vault/1.18.3/
# https://releases.hashicorp.com/vault/1.18.3/vault_1.18.3_linux_amd64.zip