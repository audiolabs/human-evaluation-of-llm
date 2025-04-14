
# README

This README gives an overview of datasets that have been created in the course of investigating methods for evaluating LLM-generated texts with humans. 

## Overview of the Dataset

The dataset consists of five data files:

1. **LLM_generated_texts**
2. **Results_AB**
3. **Results_DirectQuality**
4. **Results_BinaryDecision**
5. **Results_BWS**

Below, you will find a detailed explanation of each dataset, its structure, and how to interpret the variables.

#### Text Labels for Variables in Datasets 2.-5.

| Text Number | Text Description      |
|-------------|------------------------|
| 1           | Chat GPT Best          |
| 2           | Chat GPT Worst         |
| 3           | LLaMA Best             |
| 4           | LLaMA Worst            |
| 5           | Mistral Best           |
| 6           | Mistral Worst          |
| 7           | Luminous Best          |
| 8           | Luminous Worst         |

---

### 1. LLM_generated_texts

This dataset contains answers given by different LLM to versions of our prompts, which are outlined in the paper. 
The dataset contains two columns: index and answer. The column "index" provides information on which LLM generated a given text and the column "answer" stores the responses of the given LLM. 

### 2. Results_AB

This dataset contains data for A/B Testing. The variable names are structured as follows:

- **Prefix**: Represents the metric measured (e.g., `Honesty`).
- **Number**: Denotes the combination tested (e.g., GPT best and GPT worst text).

#### Example: Understanding the Metric `Honesty`
The combinations for `Honesty` are as follows:

| Variable Name | Text Combination     |
|---------------|-----------------------|
| Honesty_1     | GPT best vs GPT worst |
| Honesty_2     | GPT best vs LLaMA best |
| Honesty_3     | GPT best vs LLaMA worst |
| Honesty_4     | GPT best vs Mistral best |
| Honesty_5     | GPT best vs Mistral worst |
| Honesty_6     | GPT best vs Luminousbase best |
| Honesty_7     | GPT best vs Luminousbase worst |
| Honesty_8     | GPT worst vs LLaMA best |
| Honesty_9     | GPT worst vs LLaMA worst |
| Honesty_10    | GPT worst vs Mistral best |
| Honesty_11    | GPT worst vs Mistral worst |
| Honesty_12    | GPT worst vs Luminousbase best |
| Honesty_13    | GPT worst vs Luminousbase worst |
| Honesty_14    | LLaMA best vs LLaMA worst |
| Honesty_15    | LLaMA best vs Mistral best |
| Honesty_16    | LLaMA best vs Mistral worst |
| Honesty_17    | LLaMA best vs Luminousbase best |
| Honesty_18    | LLaMA best vs Luminousbase worst |
| Honesty_19    | LLaMA worst vs Mistral best |
| Honesty_20    | LLaMA worst vs Mistral worst |
| Honesty_21    | LLaMA worst vs Luminousbase best |
| Honesty_22    | LLaMA worst vs Luminousbase worst |
| Honesty_23    | Mistral best vs Mistral worst |
| Honesty_24    | Mistral best vs Luminousbase best |
| Honesty_25    | Mistral best vs Luminousbase worst |
| Honesty_26    | Mistral worst vs Luminousbase best |
| Honesty_27    | Mistral worst vs Luminousbase worst |
| Honesty_28    | Luminousbase best vs Luminousbase worst |


### 3. Results_DirectQuality

This dataset contains the ratings for each text, where every metric is paired with the corresponding text number. Each variable is rated on a scale of **1 to 5**, where:

- **1**: Low agreement
- **5**: Strong agreement

####  Variable Interpretation


| Text Number | Text Description      |
|-------------|------------------------|
| 1           | Chat GPT Best          |
| 2           | Chat GPT Worst         |
| 3           | LLaMA Best             |
| 4           | LLaMA Worst            |
| 5           | Mistral Best           |
| 6           | Mistral Worst          |
| 7           | Luminous Best          |
| 8           | Luminous Worst         |

---

**Note**: When calculating averages:
- **Individual Texts**: Calculated independently.
- **LLMs**: Best and worst texts are combined (e.g., `Honesty_1` and `Honesty_2` → `Honesty_GPT`).

---

### 4. Results_BinaryDecision

This dataset records binary decisions (e.g., Yes/No) for each text. The metrics and text descriptions match the structure in `Results_DirectQuality`.

#### Note on Calculations

- **Individual Texts**: Calculated independently.
- **LLMs**: Best and worst texts are combined (e.g., `Honesty_1` and `Honesty_2` → `Honesty_GPT`).

---

### 5. Results_BWS

This dataset contains two BIBD (Balanced Incomplete Block Design) configurations for the metrics **Honesty** and **Comprehensibility**:

- **BIBD1**: Honesty
- **BIBD2**: Comprehensibility

#### Generated BIBD Tables

**BIBD1 (Honesty):**

| Row | [1] | [2] | [3] | [4] |
|-----|-----|-----|-----|-----|
|  1  |  2  |  3  |  4  |  6  |
|  2  |  1  |  3  |  5  |  7  |
|  3  |  1  |  4  |  6  |  7  |
|  4  |  4  |  5  |  7  |  8  |
|  5  |  1  |  5  |  6  |  8  |
|  6  |  2  |  5  |  6  |  8  |
|  7  |  3  |  4  |  7  |  8  |
|  8  |  3  |  4  |  5  |  8  |

**BIBD2 (Comprehensibility):**

| Row | [1] | [2] | [3] | [4] |
|-----|-----|-----|-----|-----|
|  1  |  1  |  5  |  6  |  7  |
|  2  |  1  |  2  |  3  |  6  |
|  3  |  4  |  5  |  6  |  8  |
|  4  |  3  |  5  |  7  |  8  |
|  5  |  1  |  5  |  6  |  8  |
|  6  |  1  |  2  |  4  |  8  |
|  7  |  2  |  3  |  5  |  7  |
|  8  |  2  |  4  |  7  |  8  |

#### Text-to-Number Mapping

| Text Number | Text Description      |
|-------------|------------------------|
| 1           | Chat GPT Best          |
| 2           | Chat GPT Worst         |
| 3           | LLaMA Best             |
| 4           | LLaMA Worst            |
| 5           | Mistral Best           |
| 6           | Mistral Worst          |
| 7           | Luminous Best          |
| 8           | Luminous Worst         |

#### Example Interpretation of BIBD

- A combination like `H1` refers to **Combination 1 of Honesty**.
- Prefix:
  - `B`: Selected as the best text.
  - `W`: Selected as the worst text.

**Example**: `BH1` → Best text for **Honesty** in combination 1.

#### Calculation Notes

- **Individual Texts**: Best and worst texts are calculated independently.
- **LLMs**: Best and worst texts are combined.

#### Visual Representations

The visualizations of the BIBD configurations are provided in the attached images:
- **BIBD1.png**: Honesty
- **BIBD2.png**: Comprehensibility

---
## Results for Study Reproduction

The file Tables_Results_for_Study_Reproduction_Methods_LLM.pdf contains detailed results that we deem useful for identifying differences and similarities when this study is reproduced. 
