[syncthing]
title="Syncthing (Sync)"
desc="Syncthing Sync Protocol"
port_forward="yes"
dst.ports="22000/tcp"

[syncthing-discovery]
title="Syncthing (Discovery)"
desc="Syncthing Local Discovery Protocol"
port_forward="no"
dst.ports="21027/udp"

[syncthing-webui]
title="Syncthing (GUI)"
desc="Syncthing Web GUI (Direct)"
port_forward="yes"
dst.ports="8384/tcp"
