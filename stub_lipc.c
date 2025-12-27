#include <stdlib.h>
#include <stdio.h>

// Helper types from openlipc.h
typedef void LIPC;
typedef enum { LIPC_OK = 0 } LIPCcode;

// Stub functions
LIPC *LipcOpen(const char *service) {
    (void)service;
    return (LIPC*)malloc(1);
}

void LipcClose(LIPC *lipc) {
    if (lipc) free(lipc);
}

LIPCcode LipcGetIntProperty(LIPC *lipc, const char *service, const char *property, int *value) {
    (void)lipc; (void)service; (void)property;
    if (value) *value = 0;
    return LIPC_OK;
}

LIPCcode LipcSetIntProperty(LIPC *lipc, const char *service, const char *property, int value) {
    (void)lipc; (void)service; (void)property; (void)value;
    return LIPC_OK;
}

LIPCcode LipcSetStringProperty(LIPC *lipc, const char *service, const char *property, const char *value) {
    (void)lipc; (void)service; (void)property; (void)value;
    return LIPC_OK;
}
