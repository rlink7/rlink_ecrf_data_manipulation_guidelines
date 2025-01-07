import pandas as pd
import os
import glob

participant_id

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


INPUT = '/neurospin/rlink/PUBLICATION/rlink_ecrf/phenotype/ecrf/'

intput_files = glob.glob(INPUT + "*.tsv',")
print(intput_files)

df = pd.read_csv(intput_files[0], sep="\t")
print(df.head())