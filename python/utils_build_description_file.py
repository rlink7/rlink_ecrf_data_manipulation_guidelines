import pandas as pd
import os
import glob

# %% Files

"""
Files:
'dataset-clinical_mod-baseline_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-antipdep_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-antipsy_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-benzos_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-dsrdr_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-famhist_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-hcnd_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-mood_version-2.tsv',
'dataset-clinical_mod-baseline_form-postLi_tab-neurol_version-2.tsv',
'dataset-clinical_mod-baseline_form-preLi_tab-csrih_version-2.tsv',
'dataset-clinical_mod-baseline_form-preLi_tab-csrimeet_version-2.tsv',
'dataset-clinical_mod-baseline_form-preLi_tab-med_version-2.tsv',
'dataset-clinical_mod-baseline_tab-med_m-1_version-2.tsv',
'dataset-clinical_mod-baseline_tab-med_m-2_version-2.tsv',
'dataset-clinical_mod-cm_form-cm_tab-cmtrt_version-2.tsv',
'dataset-clinical_mod-cm_version-2.tsv',
'dataset-clinical_mod-eos_version-2.tsv',
'dataset-clinical_mod-inclusion_version-2.tsv',
'dataset-clinical_mod-pregnancy_tab-cmtrt_version-2.tsv',
'dataset-clinical_mod-pregnancy_tab-extrt_version-2.tsv',
'dataset-clinical_mod-pregnancy_tab-newborn_version-2.tsv',
'dataset-clinical_mod-pregnancy_tab-proc_version-2.tsv',
'dataset-clinical_mod-pregnancy_version-2.tsv',

'dataset-clinical_mod-sae_tab-cmtrt_version-2.tsv',
'dataset-clinical_mod-sae_tab-proc_version-2.tsv',
'dataset-clinical_mod-sae_tab-extrt_version-2.tsv',
'dataset-clinical_mod-sae_version-2.tsv',

'dataset-clinical_mod-visits_form-visit_version-2.tsv',
'dataset-clinical_mod-visits_form-visit_tab-csrih_version-2.tsv',
'dataset-clinical_mod-visits_form-visit_tab-csrimeet_version-2.tsv',
'dataset-clinical_mod-visits_form-visit_tab-dsrdr_version-2.tsv',
'dataset-clinical_mod-visits_form-visit_tab-hcnd_version-2.tsv',
'dataset-clinical_mod-visits_form-visit_tab-med_version-2.tsv',
"""

# %% Add file for each variable

#INPUT = '/neurospin/rlink/PUBLICATION/rlink_ecrf/phenotype/ecrf/'
INPUT = '/home/ed203246/mega/documents/projets/2017_R-LiNK/PUBLICATION/rlink_ecrf/phenotype/ecrf/'
print(INPUT + "*.tsv")

intput_files = glob.glob(INPUT + "*.tsv")
print(intput_files)

datas = {os.path.basename(file):pd.read_csv(file, sep="\t") for file in intput_files}
var, file, nrow = [], [], []

for key, df in datas.items():
    print(key, df.columns)
    var += list(df.columns)
    file += [key] * len(df.columns)
    nrow += [df.shape[0]] * len(df.columns)

fileinfo = pd.DataFrame(dict(Référence=var, file=file, nrow=nrow ))



desc = pd.read_excel(INPUT + "dataset-clinical_version-2_description.xlsx")

# Multiple sheets
with pd.ExcelWriter(INPUT + "dataset-clinical_version-2_description_file-information_tmp.xlsx") as writer:
    desc.to_excel(writer, sheet_name='Data Handling Manual RLINK', index=False)
    fileinfo.to_excel(writer, sheet_name='File Information', index=False)


