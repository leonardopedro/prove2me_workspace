-- Generated from ChapterNavierStokesFarisLavineLift.lean — solution of BookProof.NavierStokesFlow.FarisLavineLift.norm_le_norm_add_of_re_inner_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift











open FullEsa



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {x y : F} (h : 0 ≤ (inner ℂ x y : ℂ).re) :
    ‖x‖ ≤ ‖x + y‖ := by

  have hsq : ‖x + y‖ ^ 2 = ‖x‖ ^ 2 + 2 * (inner ℂ x y : ℂ).re + ‖y‖ ^ 2 := by
    simpa using norm_add_sq (𝕜 := ℂ) x y
  nlinarith [norm_nonneg x, norm_nonneg y, sq_nonneg ‖y‖, norm_nonneg (x + y)]
