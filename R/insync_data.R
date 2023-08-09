#' Synchronizing google bucket contents into Terra persistent disk.
#'
#' @param source_bucket A string representing the google bucket id such as `gs://fc-12345cfd-756f-5e19-b0c5-fbc6b26a067d`
#' @param folder_name The folder name as it appears in the Terra Workspace.
#'
#' @return Side effect; synchronized folder contents.
#' @export
#'
#' @examples
#'
insync_data <- function(source_bucket, folder_name = "data"){

  if(missing(source_bucket)) stop("Provide a source bucket ID in the format gs://xxxxx.yyy.zz")

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


