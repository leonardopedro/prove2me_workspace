-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.exists_isShiftInvert
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
open BookProof.HashimotoShiftInvert



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

theorem BookProof.HashimotoShiftInvert.exists_isShiftInvert {A : Dom →ₗ[ℂ] F} (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    {γ : ℝ} (hγ : 0 < γ) (hsurj : Function.Surjective (shiftMap A γ)) :
    ∃ R : F →L[ℂ] F, IsShiftInvert A γ R := by sorry
