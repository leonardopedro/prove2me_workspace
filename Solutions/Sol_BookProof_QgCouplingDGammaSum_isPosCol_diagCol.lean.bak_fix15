-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.isPosCol_diagCol
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {lam : ℕ → ℝ} (hlam : ∀ k, 0 ≤ lam k) : IsPosCol (diagCol lam) := by

  intro S c
  classical
  have hinner : ∀ j ∈ S,
      (∑ k ∈ S, (starRingEnd ℂ) (c j) * (diagCol lam k) j * c k)
        = ((lam j * ‖c j‖ ^ 2 : ℝ) : ℂ) := by
    intro j hj
    have hterm : ∀ k ∈ S, (starRingEnd ℂ) (c j) * (diagCol lam k) j * c k
        = if k = j then ((lam j * ‖c j‖ ^ 2 : ℝ) : ℂ) else 0 := by
      intro k _
      rcases eq_or_ne k j with hkj | hkj
      · subst hkj
        rw [if_pos rfl, diagCol, Finsupp.single_eq_same]
        have : (starRingEnd ℂ) (c k) * c k = ((‖c k‖ ^ 2 : ℝ) : ℂ) := by
          rw [Complex.conj_mul']
          norm_cast
        rw [show (starRingEnd ℂ) (c k) * ((lam k : ℝ) : ℂ) * c k
            = ((lam k : ℝ) : ℂ) * ((starRingEnd ℂ) (c k) * c k) by ring, this,
          ← Complex.ofReal_mul]
      · rw [if_neg hkj, diagCol, Finsupp.single_apply, if_neg hkj]
        ring
    rw [Finset.sum_congr rfl hterm, Finset.sum_ite_eq' S j, if_pos hj]
  rw [Finset.sum_congr rfl hinner, Complex.re_sum]
  refine Finset.sum_nonneg fun j _ => ?_
  rw [Complex.ofReal_re]
  exact mul_nonneg (hlam j) (sq_nonneg _)
