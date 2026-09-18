-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.IsShiftInvert.apply_eq
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.HashimotoShiftInvert
open BookProof.HashimotoShiftInvert.IsShiftInvert



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

theorem BookProof.HashimotoShiftInvert.IsShiftInvert.apply_eq {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (u : F) :
    A ⟨R u, h.mem u⟩ = u - (γ : ℂ) • R u := by sorry
