#' Synchronizing persistent disk contents into google bucket
#'
#' @param destination_bucket A string representing the destination bucket id such as `gs://fc-12345cfd-756f-5e19-b0c5-fbc6b26a067d`
#' @param folder_name The folder name as it appears in the persistent disk AND Terra workspace that contains data and files to sync back.
#'
#' @return Side effect, syncs data into google bucket
#' @export
#'
#' @examples
outsync_data <- function(destination_bucket, folder_name = "data"){

  if(missing(destination_bucket)) stop("Provide a destination bucket ID in the format gs://xxxxx.yyy.zz")

  # complete destination path; bucket id and folder name
  bucket_path <- stringr::str_glue("{destination_bucket}/{folder_name}/")

  # check if folder exists in the persistent disk, and thus destination
  if (!file.exists(xfun::relative_path(here::here({{folder_name}})))) {
    stop("The folder your are trying to sync does not exist on the persistent disk!")
  }

  # synch the data/files back to the bucket/ destination bucket
  AnVIL::gsutil_rsync(source = xfun::relative_path(here::here({{folder_name}})),
                      destination = {{bucket_path}},
                      # delete = TRUE,
                      dry = FALSE,
                      recursive = TRUE)

}
