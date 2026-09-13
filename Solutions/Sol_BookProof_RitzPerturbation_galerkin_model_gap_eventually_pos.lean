-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.galerkin_model_gap_eventually_pos
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_abs_minmaxGap_sub_le
import Theorems.Thm_BookProof_RitzMinMax_galerkin_gap_eventually_pos
import Theorems.Thm_BookProof_RitzMinMax_minmaxSet_nonempty
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    {eps : ℝ} (hd : ‖T - T'‖ ≤ eps) (hgap : 2 * eps < minmaxGap T) :
    ∀ᶠ m : ℕ in atTop, 0 < minmaxLevelIn T' (galerkinSpan b m) 1
      - minmaxLevelIn T' (galerkinSpan b m) 0 := by

  have h := abs_minmaxGap_sub_le T' T (minmaxSet_nonempty T' b 0) (minmaxSet_nonempty T' b 1)
  rw [← neg_sub T T', norm_neg, abs_sub_le_iff] at h
  refine galerkin_gap_eventually_pos T' b ?_
  have hle : minmaxGap T - 2 * eps ≤ minmaxGap T' := by linarith [h.2]
  simp only [minmaxGap] at hle hgap
  linarith
