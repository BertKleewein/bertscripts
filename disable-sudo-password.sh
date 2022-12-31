sudo -E sh -c "echo \"${USER}   ALL=(ALL) NOPASSWD:ALL\" >> /etc/sudoers"
echo "User ${USER} added to sudoers.  Use 'sudo visudo' to verify."
