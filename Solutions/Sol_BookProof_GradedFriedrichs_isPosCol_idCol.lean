-- Generated from ChapterGradedFriedrichs.lean — solution of BookProof.GradedFriedrichs.isPosCol_idCol
import Mathlib
import Definitions.Def_ChapterGradedFriedrichs
open BookProof.GradedFriedrichs




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin
open BookProof.FockSecondQuantization BookProof.FermionFock BookProof.GradedFock

noncomputable section

variable {γ : Type*}
variable {α β : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : IsPosCol idCol := by

  intro S c
  have h : ∀ j ∈ S, ∑ k ∈ S, (starRingEnd ℂ) (c j) * (idCol k) j * c k
      = (starRingEnd ℂ) (c j) * c j := by
    intro j hj
    rw [Finset.sum_eq_single j]
    · simp [idCol]
    · intro k _ hkj
      simp [idCol, Ne.symm hkj]
    · intro hc; exact absurd hj hc
  rw [Finset.sum_congr rfl h, Complex.re_sum]
  refine Finset.sum_nonneg fun j _ => ?_
  rw [Complex.mul_re, Complex.conj_re, Complex.conj_im]
  nlinarith [sq_nonneg (c j).re, sq_nonneg (c j).im]
