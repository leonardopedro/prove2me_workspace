-- Generated from ChapterSirkRitzPerturbation.lean — theorem BookProof.RitzPerturbation.galerkin_model_gap_tendsto
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation








noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.RitzPerturbation.galerkin_model_gap_tendsto (T T' : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) {eps : ℝ}
    (hd : ‖T - T'‖ ≤ eps) :
    Tendsto (fun m : ℕ => minmaxLevelIn T' (galerkinSpan b m) 1
        - minmaxLevelIn T' (galerkinSpan b m) 0) atTop (𝓝 (minmaxGap T')) ∧
      |minmaxGap T' - minmaxGap T| ≤ 2 * eps := by sorry
