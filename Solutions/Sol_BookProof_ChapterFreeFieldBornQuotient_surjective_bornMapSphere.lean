-- Generated from ChapterFreeFieldBornQuotient.lean — solution of BookProof.ChapterFreeFieldBornQuotient.surjective_bornMapSphere
import Mathlib
import Definitions.Def_ChapterFreeFieldBornQuotient
import Theorems.Thm_BookProof_ChapterFreeFieldBornSurj_bornMap_bornSection
import Theorems.Thm_BookProof_ChapterFreeFieldBornSurj_bornSection_mem_sphere
open BookProof.ChapterFreeFieldBornQuotient



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution : Function.Surjective (bornMapSphere n) := by

  intro p
  refine ⟨⟨bornSection p, bornSection_mem_sphere p.2⟩, ?_⟩
  exact Subtype.ext (bornMap_bornSection p.2)
