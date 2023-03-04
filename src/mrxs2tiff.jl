__precompile__(true)
module Bioformat_To_Tiff_Converter
    # module exports
    export mrxs2tiff

    """
        Convert all .mrxs files in a folder to tiff files. 
        Since mrxs files come along with a folder of data, at the moment recursive image search down the file tree is not supported.

        Arguments:
        - folder::String             -- path to folder with .mrxs files
        
        Optional Arguments:
        - tmp::String                -- path to temporary directory for pyramid files. Will be deleted in the end. (default: "tmp")
        - dir_out::String            -- path to output directory (default: folder)
        - opt_bioformats2raw::String -- runtime options for bioformats2raw conversion (default: "")
        - opt_raw2ometiff::String    -- runtime options for raw2ometiff conversion (default: "")
    """
    function mrxs2tiff(folder::String; tmp::String="tmp", dir_out::String=folder, opt_bioformats2raw::String="", opt_raw2ometiff::String="")
        # check if output directory exists
        isdir(dir_out) ? nothing : mkpath(dir_out)

        # check if temporary directory already exists
        isdir(tmp) ? warn_tmp(tmp) : nothing

        # go through directory converting all .mrxs files
        for file in readdir(folder)
            path = folder * "/" * file
            if ismrxs(path)
                fname = replace(file, ".mrxs" => "")
                mrxs2tiff(path, fname, dir_out, tmp=tmp, 
                          opt_bioformats2raw=opt_bioformats2raw, 
                          opt_raw2ometiff=opt_raw2ometiff)
            end
        end
    end

    """
        Convert single .mrxs file to tiff file. 

        Arguments:
        - path::String               -- path to .mrxs file (including .mrxs file ending)
        - fname::String              -- name of the .mrxs file (without .mrxs file ending)
        - dir_out::String            -- path to output directory 
    
        Optional Arguments:
        - tmp::String                -- path to temporary directory for pyramid files. Will be deleted in the end. (default: "tmp")
        - opt_bioformats2raw::String -- runtime options for bioformats2raw conversion (default: "")
        - opt_raw2ometiff::String    -- runtime options for raw2ometiff conversion (default: "")
    """
    function mrxs2tiff(path::String, fname::String, dir_out::String; tmp::String="tmp", opt_bioformats2raw::String="", opt_raw2ometiff::String="")
        # convert mrxs to pyramid file
        run(`bioformats2raw $(opt_bioformats2raw) $(path) $(tmp)/zarr-pyramid`)
        # convert pyramid to tiff
        run(`raw2ometiff $(opt_raw2ometiff) $(tmp)/zarr-pyramid $(dir_out)/$(fname).ome.tiff`)
        # remove temporary files
        run(`rm -r $(tmp)`)
    end

    "Check whether or not a path corresponds to an .mrxs file"
    function ismrxs(path::String)::Bool
        isfile(path) ? endswith(path, ".mrxs") : false
    end

    "Output a warning message regarding the temporary directory."
    function warn_tmp(tmp::String)
        println("The temporary directory '$(tmp)' seems to already exist!")
        println("$(tmp) will be deleted during the execution of the program.")
        println("To avoid accidental loss of data, please make sure that 'tmp' does not match any existing directories!")
        println("Stopping all processes...")

        exit(86)
    end
end