-- Generated from ChapterFreeFieldBornQuotient.lean — solution of BookProof.ChapterFreeFieldBornQuotient.continuous_bornMapSphere
import Mathlib
import Definitions.Def_ChapterFreeFieldBornQuotient
import Theorems.Thm_BookProof_ChapterFreeFieldBornCont_continuous_bornMap
import Theorems.Thm_BookProof_ChapterFreeFieldBorn_bornMap_mem_stdSimplex
open BookProof.ChapterFreeFieldBornQuotient



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : Continuous (bornMapSphere n) := by

  apply Continuous.subtype_mk
  exact continuous_bornMap.comp continuous_subtype_val
