# Guidelines to Manipulate Clinical Data

Contact:

- rlink@cea.fr

Authors:

- celine.bourdon@inserm.fr
- dimitri.papadopoulos@cea.fr
- edouard.duches@cea.fr

Content

```
documents/
├── dataset-clinical_version-2_description.pdf: Annotated eCRF
├── dataset-clinical_version-2_description_file-information.xlsx: Variable description and mapping to file
├── rlink_webinar_clinical-data_manipulation.pdf: Presentation
└── sop_eCRF.docx: Standard Operating Procedures (Detailed information)

python/
├── pixi.toml: Config file for python 
├── usecase1_extract_demographicSmokingLithemiaMarsResponse.py: use case in python
└── utils_build_description_file.py

R/
├── usecase1_extract_demographicSmokingLithemiaMarsResponse_classic.R: use case in classic R
└── usecase1_extract_demographicSmokingLithemiaMarsResponse_tidyverse.R: use case in R with tidyverse
```


## Running Python code

1. Install Pixi
   
   Linux & macOS
   ```
   curl -fsSL https://pixi.sh/install.sh | bash
   ```
   Windows
   ```
   iwr -useb https://pixi.sh/install.ps1 | iex
   ```

3. Go to the Python directory, then install the required Python packages (only the first time):

```
cd python
pixi install
```

3. Set up Python configuration:

```
cd python
pixi shell
```


## Running R code

Install [RStudio](https://posit.co/download/rstudio-desktop/)

