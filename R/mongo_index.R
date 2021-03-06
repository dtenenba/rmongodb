#' mongo.index.create flag constant - unique keys
#' 
#' \code{\link{mongo.index.create}()} flag constant - unique keys (no
#' duplicates).
#' 
#' 
#' @return 1L
#' @export mongo.index.unique
mongo.index.unique     <- 1L


#' mongo.index.create flag constant - drop duplicate keys
#' 
#' \code{\link{mongo.index.create}()} flag constant - drop duplicate keys.
#' 
#' 
#' @return 4L
#' @export mongo.index.drop.dups
mongo.index.drop.dups  <- 4L


#' mongo.index.create flag constant - background
#' 
#' \code{\link{mongo.index.create}()} flag constant - background.
#' 
#' 
#' @return 8L
#' @export mongo.index.background
mongo.index.background <- 8L


#' mongo.index.create flag constant - sparse
#' 
#' \code{\link{mongo.index.create}()} flag constant - sparse.
#' 
#' 
#' @return 16L
#' @export mongo.index.sparse
mongo.index.sparse     <- 16L



#' Add an index to a collection
#' 
#' Add an index to a collection.
#' 
#' See \url{http://www.mongodb.org/display/DOCS/Indexes}.
#' 
#' 
#' @param mongo (\link{mongo}) A mongo connection object.
#' @param ns (string) The namespace of the collection to which to add an index.
#' @param key An object enumerating the fields in order which are to
#' participate in the index. This object may be a vector of strings listing the
#' key fields or a \link{mongo.bson} object containing the key fields in the
#' desired order.
#' 
#' Alternately, \code{key} may be a list which will be converted to a
#' mongo.bson object by \code{\link{mongo.bson.from.list}()}.
#' 
#' Alternately, \code{key} may be a valid JSON character string which will be converted to a
#' mongo.bson object by \code{\link{mongo.bson.from.JSON}()}.
#' @param options (integer vector) Optional flags governing the operation:
#' \itemize{ \item\code{\link{mongo.index.unique}}
#' \item\code{\link{mongo.index.drop.dups}}
#' \item\code{\link{mongo.index.background}}
#' \item\code{\link{mongo.index.sparse}} }
#' @return NULL if successful; otherwise, a \link{mongo.bson} object describing
#' the error.\cr \code{\link{mongo.get.server.err}()} or
#' \code{\link{mongo.get.server.err.string}()} may alternately be called in
#' this case instead of examining the returned object.
#' @seealso \code{\link{mongo.find}},\cr \code{\link{mongo.find.one}},\cr
#' \code{\link{mongo.insert}},\cr \code{\link{mongo.update}},\cr
#' \code{\link{mongo.remove}},\cr \link{mongo},\cr \link{mongo.bson}.
#' @examples
#' 
#' mongo <- mongo.create()
#' if (mongo.is.connected(mongo)) {
#'     # Add a city index to collection people in database test
#'     b <- mongo.index.create(mongo, "test.people", '{"city":1}')
#'     if (!is.null(b)) {
#'         print(b)
#'         stop("Server error")
#'     }
#' 
#'     # Add an index to collection people in database test
#'     # which will speed up queries of age followed by name
#'     b <- mongo.index.create(mongo, "test.people", c("age", "name"))
#' 
#'     buf <- mongo.bson.buffer.create()
#'     mongo.bson.buffer.append(buf, "age", 1L)
#'     mongo.bson.buffer.append(buf, "name", 1L)
#'     key <- mongo.bson.from.buffer(buf)
#' 
#'     # add an index using an alternate method of specifying the key fields
#'     b <- mongo.index.create(mongo, "test.people", key)
#' 
#'     # create an index using list of that enumerates the key fields
#'     b <- mongo.index.create(mongo, "test.cars", list(make=1L, model=1L))
#' }
#' 
#' @export mongo.index.create
mongo.index.create <- function(mongo, ns, key, options=0L) {
  
  #check for mongodb connection
  if( !mongo.is.connected(mongo))
    stop("No mongoDB connection!")
  
  #validate and process input
  if( class(key) == "mongo.bson"){
    key <- key
  } else if ( class(key) == "list"){
    key <- mongo.bson.from.list(key)
  } else if ( class(key) == "character"){
    if( isValidJSON(I(key)))
        key <- mongo.bson.from.JSON(key)
    else
      key <- key
  }
  
  .Call(".mongo.index.create", mongo, ns, key, options)
}


