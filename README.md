# acdc_deposit
Simple repository to facilitate preparation of data prior to data transfer for the Australian Cardiovascular disease Data Commons 


## Usage

To create a directory structure for a study with ID `AusDiab` run:

```sh
git clone https://github.com/AustralianBioCommons/acdc_deposit.git
```

```sh
bash create_template.sh -s AusDiab
```

To create the directory structure in a custom destination run:
```sh
bash create_template.sh -s AusDiab -o path/to/target/dest
```

This will create a directory named `YYYY-MM-DD_AusDiab_ACDC_Data_Transfer` (where `YYYY-MM-DD` is the current date).



### Options
- `-s STUDY_ID`: The study identifier used to name the root directory. This is a required argument.
- `-o OUTPUT_DIR`: Specify the output directory where the structure will be created. Default is the current directory.



### Directory Structure

The script will create the following directory structure:

```
YYYY-MM-DD_STUDY_ID_ACDC_Data_Transfer/
├── clinical/
├── genomic/
├── imaging/
├── metabolomic/
├── proteomic/
├── study/
└── study/data_dictionaries/
```

### Manifest File

A `manifest.tsv` file will be created in the root directory with the following header:

```
study_id	subject_id	file_path	file_name	data_category	file_size	md5_hash
```


### License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.
