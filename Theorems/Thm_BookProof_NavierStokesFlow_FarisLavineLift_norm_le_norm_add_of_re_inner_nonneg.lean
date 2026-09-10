-- Generated from ChapterNavierStokesFarisLavineLift.lean — theorem BookProof.NavierStokesFlow.FarisLavineLift.norm_le_norm_add_of_re_inner_nonneg
import Mathlib
import Definitions.Def_ChapterNavierStokesFarisLavineLift
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FarisLavineLift













variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.NavierStokesFlow.FarisLavineLift.norm_le_norm_add_of_re_inner_nonneg {x y : F} (h : 0 ≤ (inner ℂ x y : ℂ).re) :
    ‖x‖ ≤ ‖x + y‖ := by sorry
