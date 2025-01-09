import pandas as pd
import os

# %% Set path to inout data and output results according to your local configuration

INPUT = '/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/data/'
OUTPUT = '/home/ed203246/git/rlink_ecrf_data_manipulation_guidelines/outputs/'

# %% Read Data

vars = ["participant_id", "AGE", "SEX"]
df = pd.read_csv(INPUT + "dataset-clinical_mod-inclusion_version-2.tsv", sep='\t', na_values=['ND'])
df1 = df[vars]
df1.shape == (168, 3)

vars = ["participant_id", "WHOA1A_PLI", "HEIGHT_PRELI", "WEIGHT_PRELI"]
df = pd.read_csv(INPUT + "dataset-clinical_mod-baseline_version-2.tsv", sep='\t', na_values=['ND'])
df2 = df[vars]
df2["BMI"] = df2["WEIGHT_PRELI"] / (df2["HEIGHT_PRELI"] ** 2)
df2.shape == (168, 5)

vars = ["participant_id", "FORM_F_VISIT",
        "WHOA2A", "PLIMRI", "ERYLIMRI", "PLI", "ERYLI", "PLI2",
        "MARS1V", "MARS2V", "MARS3V", "MARS4V", "MARS5V", "MARS6V", "MARS7V", "MARS8V",
        "MARS9V", "MARS10V"]
df = pd.read_csv(INPUT + "dataset-clinical_mod-visits_form-visit_version-2.tsv", sep='\t', na_values=['ND'])
df3 = df[vars]
df3.shape == (2449, 18)
# Select M03 => FORM_F_VISIT == 'F_VISIT_1'
df3 = df3[df3.FORM_F_VISIT == 'F_VISIT_1']
# drop FORM_F_VISIT column and suffix variable with "_M03"
df3 = df3.drop(['FORM_F_VISIT'], axis=1)
df3 = df3.rename(columns={"MARS1V":"MARS1_M03", "MARS2V":"MARS2_M03", "MARS3V":"MARS3_M03",
            "MARS4V":"MARS4_M03", "MARS5V":"MARS5_M03", "MARS6V":"MARS6_M03",
            "MARS7V":"MARS7_M03", "MARS8V":"MARS8_M03", "MARS9V":"MARS9_M03",
            "MARS10V":"MARS10_M03"})


df3.shape == (142, 18)

vars = ["participant_id",
        "MARS1_PRELI", "MARS2_PRELI", "MARS3_PRELI", "MARS4_PRELI", "MARS5_PRELI",
        "MARS6_PRELI", "MARS7_PRELI", "MARS8_PRELI", "MARS9_PRELI", "MARS10_PRELI",
        "QIDSTSC_PRELI", "BRMSTSC_PRELI"]
df = pd.read_csv(INPUT + "dataset-clinical_mod-baseline_version-2.tsv", sep='\t', na_values=['ND'])
df4 = df[vars]
df4.shape == (168, 13)

vars = ["participant_id", "Response.Status.at.end.of.follow.up"]
df = pd.read_csv(INPUT + "dataset-clinical_version-2_outcome.tsv", sep='\t', na_values=['ND'])
df5 = df[vars]
df5.participant_id = ["sub-"+ str(id) for id in df5.participant_id]
df5.shape == (159, 2)


# %% Merge tables using "participant_id" (used by default)

table = pd.merge(pd.merge(pd.merge(pd.merge(df1, df2), df3), df4), df5)

# %% Save to excel file

table.to_excel(OUTPUT + "data_demoSmokLiMarsResponse_python.xlsx", index=False)

