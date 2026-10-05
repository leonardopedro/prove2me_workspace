-- Generated from ChapterSpectralMultiplication.lean — solution of BookProof.ChapterSpectralMultiplication.vectorState_one
import Mathlib
import Definitions.Def_ChapterSpectralMultiplication
open BookProof.ChapterSpectralMultiplication



open MeasureTheory Complex
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution (hxi : ‖xi‖ = 1) : vectorState T hT xi 1 = 1 := by

  simp only [vectorState_apply, map_one]
  simp [inner_self_eq_norm_sq_to_K, hxi]
