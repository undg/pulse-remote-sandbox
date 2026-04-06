# pulse-remote-vm

A QEMU/KVM Arch Linux VM for remote audio E2E testing.

| Account | Username | Password |
| ------- | -------- | -------- |
| root    | `pr`     | `pr`     |
| user    | `pr`     | `pr`     |

Full setup guide: https://undg.dev/posts/2026-06-04-qemu-kvm-create-arch-linux-vm-for-audio-e2e-testing/

## Quick Start

```bash
make base-start      # Start VM with GUI and audio
make snapshot-fresh  # Create or reset VM to fresh state
make snapshot-start  # Start headless with serial console
```

Run `make help` for all commands.
