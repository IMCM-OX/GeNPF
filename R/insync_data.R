#' Synchronizing google bucket contents into Terra persistent disk.
#'
#' @param source_bucket A string representing the google bucket id.
#' @param folder_name The folder name as it appears in the Terra Workspace.
#'
#' @return Side effect; synchronized folder contents.
#' @export
#'
#' @examples
#'
insync_data <- function(source_bucket = AnVIL::avbucket(), folder_name = "data"){

  # use case source_bucket + folder_name
  bucket_path <- stringr::str_glue("{source_bucket}/{folder_name}/")

  # create `folder_name` directory directory
  if (!file.exists(xfun::relative_path(here::here({{folder_name}})))){
    dir.create(xfun::relative_path(here::here({{folder_name}})),
               recursive = TRUE)}

  # synchronize files from google bucket to local disk
  AnVIL::gsutil_rsync(source = {{bucket_path}},
               destination = xfun::relative_path(here::here({{folder_name}})),
               # delete = TRUE,
               dry = FALSE,
               recursive = TRUE)
}
