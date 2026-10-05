-- Generated from ChapterCyclicDecomposition.lean — solution of BookProof.ChapterCyclicDecomposition.self_mem_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
import Theorems.Thm_BookProof_ChapterCyclicDecomposition_cfcHom_apply_mem_cyclicSubspace
open BookProof.ChapterCyclicDecomposition



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

set_option maxHeartbeats 1000000 in
theorem solution (xi : H) : xi ∈ cyclicSubspace T hT xi := by

  have h := cfcHom_apply_mem_cyclicSubspace T hT xi 1
  rwa [map_one] at h
