# Notes Inbox

Capture notes here for organization at a later time. There may be some notes
that should remain to detail items from the README.md file.

## Docker Repository Key on Debian

**Problem:**

`apt` displays a warning: "Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details." This indicates an insecure and outdated method of managing repository keys. Note that `apt-key` itself is deprecated and has been removed in newer apt releases (apt 3.x, e.g. Debian 13+).

**Solution:**

1.  **Create a dedicated keyring file:** Docker now publishes an ASCII-armored key, so no `--dearmor` step is needed.

    ```bash
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    ```

2.  **Modify the Docker repository source list:**

    Edit `/etc/apt/sources.list.d/docker.list` (or similar) and add `signed-by`:

    ```
    deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian <release> stable
    ```
    Replace `<release>` with the target Debian release. e.g. `bookworm`

3.  **Update apt:**

    ```bash
    sudo apt update
    ```

4.  **(Optional) Remove the key from the legacy keyring:** On systems that still ship `apt-key`:

    ```bash
    apt-key list  # Find the Docker key's ID
    sudo apt-key del <keyid>
    ```

    Where `apt-key` is gone, remove `/etc/apt/trusted.gpg` only if it contains nothing you still need.

**Explanation:**

*   Dedicated keyring + `signed-by` restricts trust, improving security.
*   Legacy keyring removal prevents conflicts.
