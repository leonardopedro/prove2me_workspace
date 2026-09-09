-- Generated from ChapterHashimotoComplexShifts.lean — theorem BookProof.HashimotoShiftInvert.isShiftInvertC_neg_of_isShiftInvert
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
open BookProof.HashimotoShiftInvert


















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

theorem BookProof.HashimotoShiftInvert.isShiftInvertC_neg_of_isShiftInvert {A : Dom →ₗ[ℂ] F} {c : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A c R) : IsShiftInvertC A (-(c : ℂ)) (-R) := by sorry
