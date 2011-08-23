#include "symbols.h"

SEXP sym_mongo;
SEXP sym_host;
SEXP sym_name;
SEXP sym_username;
SEXP sym_timeout;
SEXP sym_mongo_bson;
SEXP sym_mongo_bson_buffer;
SEXP sym_mongo_bson_iterator;
SEXP sym_mongo_oid;
SEXP sym_increment;
SEXP sym_scope;
SEXP sym_mongo_cursor;
SEXP sym_options;
SEXP sym_subtype;
SEXP sym_length;
SEXP sym_mongo_gridfs;
SEXP sym_mongo_gridfile;
SEXP sym_mongo_gridfile_writer;


void install_mongo_symbols() {
    sym_mongo = install("mongo");
    sym_host = install("host");
    sym_name = install("name");
    sym_username = install("username");
    sym_timeout = install("timeout");
    sym_mongo_bson = install("mongo.bson");
    sym_mongo_bson_buffer = install("mongo.bson.buffer");
    sym_mongo_bson_iterator = install("mongo.bson.iterator");
    sym_mongo_oid = install("mongo.oid");
    sym_increment = install("increment");
    sym_scope = install("scope");
    sym_mongo_cursor = install("mongo.cursor");
    sym_options = install("options");
    sym_subtype = install("subtype");
    sym_length = install("length");
    sym_mongo_gridfs = install("mongo.gridfs");
    sym_mongo_gridfile = install("mongo.gridfile");
    sym_mongo_gridfile_writer = install("mongo.gridfile.writer");
}
