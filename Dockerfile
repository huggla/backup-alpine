FROM huggla/alpine-slim:20180907-edge as stage1

COPY ./rootfs /rootfs

RUN mkdir -p /rootfs/usr/local/bin/functions \
 && cd /rootfs/usr/local/bin \
 && ln -s ../../../start/includeFunctions ./ \
 && cd cd /rootfs/usr/local/bin/functions \
 && ln -s ../../../../start/functions/readEnvironmentVars ../../../../start/functions/runBinCmdAsLinuxUser ../../../../start/functions/execCmdAsLinuxUser ../../../../start/functions/trim ./

FROM huggla/base:20180907-edge

COPY --from=stage1 /rootfs /

ENV VAR_FINAL_COMMAND="/usr/sbin/crond -f -d 8" \
    VAR_FINAL_CMD_AS_ROOT="yes" \
    VAR_BACKUP_DIR="/backup" \
    VAR_DELETE_DUPLICATES="yes"
