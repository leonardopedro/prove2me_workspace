-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.IsShiftInvert.isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.HashimotoShiftInvert
open BookProof.HashimotoShiftInvert.IsShiftInvert



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

theorem BookProof.HashimotoShiftInvert.IsShiftInvert.isSelfAdjoint [CompleteSpace F] {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A) : IsSelfAdjoint R := by sorry
