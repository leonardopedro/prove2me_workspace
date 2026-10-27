-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.gp_append
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

set_option maxHeartbeats 1000000 in
theorem solution (A : Fin 4 → M4) (l₁ l₂ : List (Fin 4)) :
    gp A (l₁ ++ l₂) = gp A l₁ * gp A l₂ := by

  induction l₁ with
  | nil => simp [gp]
  | cons a t ih => simp [gp, ih, mul_assoc]
