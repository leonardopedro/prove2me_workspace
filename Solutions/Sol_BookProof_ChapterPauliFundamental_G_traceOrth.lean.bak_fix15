-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.G_traceOrth
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_GZ_traceOrth
import Theorems.Thm_BookProof_ChapterPauliFundamental_G_eq_map
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution (S T : Finset (Fin 4)) :
    (G S * (G T)ᵀ).trace = if S = T then 4 else 0 := by

  have h := GZ_traceOrth S T
  have hmap : (G S * (G T)ᵀ) = (GZ S * (GZ T)ᵀ).map (Int.cast : ℤ → ℂ) := by
    rw [G_eq_map, G_eq_map]
    ext i j
    simp [Matrix.mul_apply, Matrix.map_apply, Matrix.transpose_apply]
  have htr : ((GZ S * (GZ T)ᵀ).map (Int.cast : ℤ → ℂ)).trace
      = ((GZ S * (GZ T)ᵀ).trace : ℂ) := by
    simp [Matrix.trace, Matrix.diag_apply, Matrix.map_apply]
  rw [hmap, htr, h]
  split <;> simp
