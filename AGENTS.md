# pulse-remote-vm

A QEMU/KVM Arch Linux virtual machine setup for remote development/testing.

## Credentials

- **root**: `pr`
- **user**: `pr`
- **password**: `pr`

## Make Commands

Run `make help` for full list.

### Primary Workflows

```bash
# Start base VM with GUI and audio (for maintenance)
make base-start

# Reset test VM from base (fresh state)
make snapshot-reset

# Start test VM headless with serial console (for testing)
make snapshot-start
```

### VM Lifecycle

- `base-start`: Launch base VM with GUI display, audio, SSH on localhost:2222
- `snapshot-start`: Launch snapshot VM headless with serial console, SSH on localhost:2222
- `snapshot-reset`: Delete and recreate snapshot from base image (fresh state)
- `base-freeze` / `base-unfreeze`: Toggle base image writability

## VM Configuration

- **Base image**: `arch-base.qcow2` (golden image)
- **Snapshot image**: `arch-snapshot.qcow2` (derived from base, ephemeral)
- **ISO**: `archlinux-x86_64.iso` (for initial setup)
- **Memory**: 2GB
- **SSH access**: `ssh -p 2222 pr@localhost`

## Architecture Notes

- KVM acceleration required (`-accel kvm`)
- Audio via PulseAudio (`-audiodev pa`)
- Networking uses user mode with port forwarding (host 2222 → VM 22)
- Snapshot is a qcow2 overlay on the base image

## Prerequisites

- QEMU with KVM support
- qemu-img for snapshot management
- PulseAudio for audio forwarding
