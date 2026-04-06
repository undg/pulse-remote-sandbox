## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## base-start    : Start the base audio VM with GUI and audio output
.PHONY: base-start
base-start:
	qemu-system-x86_64 -accel kvm \
		-m 2G \
		-hda arch-base.qcow2 \
		-audiodev pa,id=snd0 \
		-device intel-hda \
		-device hda-duplex,audiodev=snd0 \
		-nic user,hostfwd=tcp::2222-:22

## base-freeze   : Make base VM image read-only
.PHONY: base-freeze
base-freeze:
	chmod 444 arch-base.qcow2

## base-unfreeze : Make base VM image writable again
.PHONY: base-unfreeze
base-unfreeze:
	chmod 644 arch-base.qcow2

## snapshot-start : Start test VM (headless, serial console)
.PHONY: snapshot-start
snapshot-start:
	qemu-system-x86_64 -accel kvm \
		-m 2G \
		-hda arch-snapshot.qcow2 \
		-audiodev pa,id=snd0 \
		-device intel-hda \
		-device hda-duplex,audiodev=snd0 \
		-display none \
		-serial stdio \
		-nic user,hostfwd=tcp::2222-:22

## snapshot-fresh : Create or reset VM to fresh state from base
.PHONY: snapshot-fresh
snapshot-fresh:
	rm -f arch-snapshot.qcow2
	qemu-img create \
		-f qcow2 \
		-F qcow2 \
		-b arch-base.qcow2 arch-snapshot.qcow2
