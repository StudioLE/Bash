
### Bash Scripts

Simple Bash scripts to improve the CLI experience. Primarily developed for Ubuntu 22.04 but likely compatible with other Debian distros.

*You should never trust scripts you aren't familiar with. Piping straight to bash is unsafe.*

*tl;dr: You probably shouldn't use these scripts unless you wrote them yourself.*

### [disable-motd](https://github.com/StudioLE/Bash/blob/main/disable-motd)

Disable the most verbose parts of Ubuntu's default the Message of the Day (MOTD) displayed on login.

```bash
# Run
curl -fsS https://bash.studiole.uk/disable-motd | sudo bash

# Check MOTD
run-parts /etc/update-motd.d
```

### [motd-hostname](https://github.com/StudioLE/Bash/blob/main/motd-hostname)

Add a stylised ANSI artwork of the hostname to the Message of the Day (MOTD) displayed on login.

```bash
# Install figlet
curl -fsS https://install.studiole.uk/figlet | sudo bash

# Install motd-hostname
curl -fsS https://install.studiole.uk/motd-hostname | sudo bash

# Check MOTD
run-parts /etc/update-motd.d
```

### [motd-system](https://github.com/StudioLE/Bash/blob/main/motd-system)

Add a simple compact snapshot of system resource use to the Message of the Day (MOTD) displayed on login. Showing CPU, Memory, Disk, Swap

```bash
# Install
curl -fsS https://install.studiole.uk/motd-system | sudo bash

# Check MOTD
run-parts /etc/update-motd.d
```

### [network-test](https://github.com/StudioLE/Bash/blob/main/network-test)

A simple script to test network connectivity. 
- Attempts to `ping` external servers via IPv4, IPv6 and DNS.
- Attempts to `curl` to determine the external IPv4 and IPv6 addresses.

```bash
# Run once
curl -fsS https://bash.studiole.uk/network-test | sudo bash
```
```bash
# Install
curl -fsS https://install.studiole.uk/network-test | sudo bash

# Run
network-test
```

### [upgrade-packages](https://github.com/StudioLE/Install/blob/main/src/upgrade-packages)

A basic script to quietly and non-interactively update and upgrade packages via `apt`.

``` bash
# Run once
curl -fsS https://bash.studiole.uk/upgrade-packages | sudo bash
```

``` bash
# Install
curl -fsS https://install.studiole.uk/upgrade-packages | sudo bash

# Run
upgrade-packages
```