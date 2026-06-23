function duck
    if test (count $argv) -lt 1
        echo "Usage: duck <file>" >&2
        return 1
    end

    set file $argv[1]

    if string match -q '*.parquet' $file
        set reader read_parquet
    else if string match -q '*.csv' $file
        set reader read_csv
    else
        echo "Unsupported file type: $file" >&2
        return 1
    end

    duckdb :memory: -init (echo "CREATE TABLE input AS SELECT * FROM $reader('$file');" | psub)
end
