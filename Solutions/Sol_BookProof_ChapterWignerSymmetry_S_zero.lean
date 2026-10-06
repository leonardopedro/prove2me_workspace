-- Generated from ChapterWignerSymmetry.lean — solution of BookProof.ChapterWignerSymmetry.S_zero
import Mathlib
import Definitions.Def_ChapterWignerSymmetry
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_norm
open BookProof.ChapterWignerSymmetry



open scoped InnerProductSpace ComplexConjugate
open Finset


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


variable {T : E → E}

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable {T : E → E}
variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {S : (ι → ℂ) → (ι → ℂ)} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hS : WignerCoord S o) {v : ι → ℂ} {k : ι} (h : v k = 0) : S v k = 0 := by

  have hn := hS.coord_norm v k
  rw [h] at hn
  simpa using hn
