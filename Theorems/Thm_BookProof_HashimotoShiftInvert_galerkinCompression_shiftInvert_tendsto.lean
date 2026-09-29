-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.galerkinCompression_shiftInvert_tendsto
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_BookProof.ChapterClosureUniqueness

open BookProof.HashimotoShiftInvert



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

theorem BookProof.HashimotoShiftInvert.galerkinCompression_shiftInvert_tendsto {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (b : HilbertBasis ℕ ℂ F) (u : F) :
    ∃ (x : F) (hx : x ∈ Dom), A ⟨x, hx⟩ + (γ : ℂ) • x = u ∧
      Tendsto (fun m : ℕ => galerkinCompression R b m u) atTop (nhds x) := by sorry
