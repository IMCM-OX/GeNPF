#' Synchronizing google bucket contents into Terra persistent disk.
#'
#' @param source_bucket A string representing the google bucket id such as `gs://fc-12345cfd-756f-5e19-b0c5-fbc6b26a067d`
#' @param folder_name The folder name as it appears in the Terra Workspace.
#' @param sub_folder The data sub-folder you want to suncy/import.
#' @return Side effect; synchronized folder contents.
#' @export
#'
#' @examples
#'
insync_data <- function(source_bucket, folder_name = "data", sub_folder){

  # check that the bucket ID is provided
  if(missing(source_bucket)) stop("Provide a source bucket ID in the format gs://xxxxx.yyy.zz")


  # create `folder_name` directory directory
  if (!file.exists(xfun::relative_path(here::here({{folder_name}})))){
    dir.create(xfun::relative_path(here::here({{folder_name}})),
               recursive = TRUE)}

  # for "data" folder, MUST provide a sub-folder for specific dataset
  if (folder_name == "data"){

    # check if subfolder is provided
    if(missing(sub_folder)) stop("Provide a'subfolder' name argument, name as listed on Terra")

    # make sure sub-folders are correct
    # Given list of URLs
    sub_folders <- c(
      AnVIL::gsutil_ls(stringr::str_glue("{source_bucket}/data"))
    )

    # Extract the last part between slashes for each URL
    terminal_ends <- sub(".*/([^/]+)/$", "\\1", sub_folders)[-1]

    if (!sub_folder %in% terminal_ends) stop("Check the spelling of the subfolder vs Terra")

    # use case source_bucket + folder_name
    bucket_path <- stringr::str_glue("{source_bucket}/{folder_name}/{sub_folder}/")

    # create `folder_name` for sub-folder directory directory directory
    if (!file.exists(xfun::relative_path(here::here({{folder_name}}, {{sub_folder}})))){
      dir.create(xfun::relative_path(here::here({{folder_name}}, {{sub_folder}})),
                 recursive = TRUE)}

    # synchronize files from google bucket to local disk
    AnVIL::gsutil_rsync(source = {{bucket_path}},
                        destination = xfun::relative_path(here::here({{folder_name}}, {{sub_folder}})),
                        # delete = TRUE,
                        dry = FALSE,
                        recursive = TRUE)

  } else {

    # use case source_bucket + folder_name
    bucket_path <- stringr::str_glue("{source_bucket}/{folder_name}/")

    # synchronize files from google bucket to local disk
    AnVIL::gsutil_rsync(source = {{bucket_path}},
                        destination = xfun::relative_path(here::here({{folder_name}})),
                        # delete = TRUE,
                        dry = FALSE,
                        recursive = TRUE)
  }

}
