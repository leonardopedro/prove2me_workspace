-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.G_span
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_G_linearIndependent
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution : Submodule.span ℂ (Set.range G) = ⊤ := by

  have hcard : Fintype.card (Finset (Fin 4)) = Module.finrank ℂ M4 := by
    rw [Module.finrank_matrix]
    simp
  have := (basisOfLinearIndependentOfCardEqFinrank G_linearIndependent hcard).span_eq
  rwa [coe_basisOfLinearIndependentOfCardEqFinrank] at this
