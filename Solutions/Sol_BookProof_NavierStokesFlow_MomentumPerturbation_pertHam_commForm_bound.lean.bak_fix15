-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_commForm_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Theorems.Thm_BookProof_FarisLavine_commForm_eq
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_quadForm_ge_norm_sq
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_diagMax_symmetricOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (hc : ∀ k, 1 ≤ c k) (u w : maxDom c)
    (x : maxDom c) :
    |commForm (pertHam c (u : L2I ι) (w : L2I ι)) (diagMax c) x|
      ≤ (2 * (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖))
        * quadForm (diagMax c) x := by

  have hdiag : (inner ℂ (diagMax c x) (diagMax c x) : ℂ).im = 0 := by
    simpa using inner_self_im (𝕜 := ℂ) ((diagMax c x))
  have hsplit : (inner ℂ (pertHam c (u : L2I ι) (w : L2I ι) x) (diagMax c x) : ℂ).im
      = (inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ).im := by
    rw [pertHam_apply, inner_add_left, Complex.add_im, hdiag, zero_add]
  have hu : (inner ℂ ((u : L2I ι)) (diagMax c x) : ℂ) = inner ℂ (diagMax c u) ((x : L2I ι)) :=
    (diagMax_symmetricOn c u x).symm
  have hw : (inner ℂ ((w : L2I ι)) (diagMax c x) : ℂ) = inner ℂ (diagMax c w) ((x : L2I ι)) :=
    (diagMax_symmetricOn c w x).symm
  have hexp : (inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ)
      = (starRingEnd ℂ) (inner ℂ ((u : L2I ι)) ((x : L2I ι)) : ℂ)
          * inner ℂ (diagMax c w) ((x : L2I ι))
        + (starRingEnd ℂ) (inner ℂ ((w : L2I ι)) ((x : L2I ι)) : ℂ)
          * inner ℂ (diagMax c u) ((x : L2I ι)) := by
    simp only [rankTwo_apply, inner_add_left, inner_smul_left]
    rw [hu, hw]
  have hbound : ‖(inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ)‖
      ≤ (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖)
        * ‖(x : L2I ι)‖ ^ 2 := by
    rw [hexp]
    refine le_trans (norm_add_le _ _) ?_
    rw [norm_mul, norm_mul, RCLike.norm_conj, RCLike.norm_conj]
    have h1 : ‖(inner ℂ ((u : L2I ι)) ((x : L2I ι)) : ℂ)‖ ≤ ‖(u : L2I ι)‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    have h2 : ‖(inner ℂ (diagMax c w) ((x : L2I ι)) : ℂ)‖ ≤ ‖diagMax c w‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    have h3 : ‖(inner ℂ ((w : L2I ι)) ((x : L2I ι)) : ℂ)‖ ≤ ‖(w : L2I ι)‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    have h4 : ‖(inner ℂ (diagMax c u) ((x : L2I ι)) : ℂ)‖ ≤ ‖diagMax c u‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    nlinarith [norm_nonneg (inner ℂ ((u : L2I ι)) ((x : L2I ι)) : ℂ),
      norm_nonneg (inner ℂ (diagMax c w) ((x : L2I ι)) : ℂ),
      norm_nonneg (inner ℂ ((w : L2I ι)) ((x : L2I ι)) : ℂ),
      norm_nonneg (inner ℂ (diagMax c u) ((x : L2I ι)) : ℂ),
      norm_nonneg ((x : L2I ι)), norm_nonneg ((u : L2I ι)), norm_nonneg ((w : L2I ι)),
      norm_nonneg (diagMax c w), norm_nonneg (diagMax c u),
      mul_nonneg (norm_nonneg ((u : L2I ι))) (norm_nonneg ((x : L2I ι))),
      mul_nonneg (norm_nonneg (diagMax c w)) (norm_nonneg ((x : L2I ι))),
      mul_nonneg (norm_nonneg ((w : L2I ι))) (norm_nonneg ((x : L2I ι))),
      mul_nonneg (norm_nonneg (diagMax c u)) (norm_nonneg ((x : L2I ι)))]
  have hquad : ‖(x : L2I ι)‖ ^ 2 ≤ quadForm (diagMax c) x :=
    diagMax_quadForm_ge_norm_sq c hc x
  have him : |(inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ).im|
      ≤ (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖)
        * ‖(x : L2I ι)‖ ^ 2 :=
    le_trans (Complex.abs_im_le_norm _) hbound
  have hcnn : (0 : ℝ) ≤ ‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖ := by
    positivity
  rw [commForm_eq, hsplit, abs_mul]
  have habs : |(-2 : ℝ)| = 2 := by norm_num
  rw [habs]
  nlinarith [him, hquad, hcnn, sq_nonneg ‖(x : L2I ι)‖]
