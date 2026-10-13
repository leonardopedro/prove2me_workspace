-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.IsShiftInvert.apply_eq
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterAbelianDiagonalCountable
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterComplexShiftCore
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology
open BookProof.ChapterAbelianDiagonalCountable

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (u : F) :
    A ⟨R u, (h.2 u).choose⟩ = u - (γ : ℂ) • R u :=
  eq_sub_of_add_eq (h.2 u).choose_spec
