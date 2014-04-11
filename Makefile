.PHONY: help
help:
	@echo Usage: make [command]
	@echo Commands:
	@echo "	all 	- build, unpatch"
	@echo "	build 	- patch -> go install"
	@echo "	patch 	- apply all patches"
	@echo "	unpatch - undo/unapply all patches"
	@echo "	refresh - update the quilt patchset"
	@echo "	update 	- pull in new go source from GOROOT"
	@echo "	clean 	- unpatch & clean up git"
	@echo ""
	@echo "To update binary run... (* requires go workspace *)"
	@echo "	make all->clean"
	@echo ""
	@echo "To update to new source, make..."
	@echo "	make update->commit->patch->[fix]->refresh->clean"
	@echo ""
	@echo "To work on patch..."
	@echo "	make patch->[work]->refresh->clean"

all: build unpatch

build: patch
	go install

# to apply patch to work on it or build
patch:
	quilt push -a

# to remove patches for commiting them or updating upstream code
unpatch:
	quilt pop -a || true

# after working on a patch, to update it.
refresh:
	quilt refresh

# update fmt code from GO sources
update: check-goroot
	find ${GOROOT}/src/cmd/gofmt -maxdepth 1 -type f \
		! -name '*_test.go' -exec cp {} ./ \;
	find ${GOROOT}/src/pkg/go/printer -maxdepth 1 -type f \
		! -name '*_test.go' -exec cp {} ./printer \;

check-goroot:
ifndef GOROOT
	$(error GOROOT is undefined)
endif

clean: unpatch
	git reset --hard
	git clean -f
