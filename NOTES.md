# Notes Inbox

Capture notes here for organization at a later time. There may be some notes
that should remain to detail items from the README.md file.

## Docker Repository Key Deprecation on Debian

**Problem:**

`apt` displays a warning: "Key is stored in legacy trusted.gpg keyring (/etc/apt/trusted.gpg), see the DEPRECATION section in apt-key(8) for details." This indicates an insecure and outdated method of managing repository keys.

**Solution:**

1.  **Create a dedicated keyring file:**

    ```bash
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    ```

2.  **Modify the Docker repository source list:**

    Edit `/etc/apt/sources.list.d/docker.list` (or similar) and add `signed-by`:

    ```
    deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian <release> stable
    ```
    Replace `<release>` with the target Debian release. e.g. `bookworm`

3.  **Update apt:**

    ```bash
    sudo apt update
    ```

4.  **(Optional) Remove the key from the legacy keyring:**

    ```bash
    apt-key list  # Find the Docker key's ID
    sudo apt-key del <keyid>
    ```

**Explanation:**

*   Dedicated keyring + `signed-by` restricts trust, improving security.
*   Legacy keyring removal prevents conflicts.
