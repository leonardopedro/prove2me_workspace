-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.compression_rayleigh_real
import Mathlib
import Definitions.Def_ChapterH7
import Theorems.Thm_BookProof_ChapterH7_inner_self_real
import Theorems.Thm_BookProof_ChapterH6_krylov_rayleigh_transfer
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (X : E →L[ℂ] E)
    (hX : IsSelfAdjoint X) (y : F) : (inner ℂ y (compress V X y) : ℂ).im = 0 := by

  rw [krylov_rayleigh_transfer]
  exact inner_self_real X hX (V y)
