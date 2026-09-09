-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.galerkin_model_gap_tendsto
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_abs_minmaxGap_sub_le
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F) {eps : ℝ}
    (hd : ‖T - T'‖ ≤ eps) :
    Tendsto (fun m : ℕ => minmaxLevelIn T' (galerkinSpan b m) 1
        - minmaxLevelIn T' (galerkinSpan b m) 0) atTop (𝓝 (minmaxGap T')) ∧
      |minmaxGap T' - minmaxGap T| ≤ 2 * eps := by

  refine ⟨galerkin_gap_tendsto T' b, ?_⟩
  have h := abs_minmaxGap_sub_le T' T (minmaxSet_nonempty T' b 0) (minmaxSet_nonempty T' b 1)
  rw [← neg_sub T T', norm_neg] at h
  linarith [h, abs_nonneg (minmaxGap T' - minmaxGap T)]
