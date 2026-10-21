-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.dGamma_diagCol_apply
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
import Theorems.Thm_BookProof_QgCouplingDGammaSum_creVec_single
import Theorems.Thm_BookProof_QgCouplingDGammaSum_creA_annA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_eq_sum
import Theorems.Thm_BookProof_FockSecondQuantization_support_subset_modes
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) (u : FockAlg) (α : Conf) :
    dGamma (diagCol lam) u α = ((occEnergy lam α : ℝ) : ℂ) * u α := by

  classical
  rcases eq_or_ne (u α) 0 with hu | hu
  · rw [hu, mul_zero]
    rw [dGamma_eq_sum _ (Finset.Subset.refl (modes u))]
    have : ∀ k ∈ modes u, creVec (diagCol lam k) (annA k u) α = 0 := by
      intro k _
      rw [diagCol, creVec_single]
      simp only [Finsupp.smul_apply, smul_eq_mul, creA_annA_apply, hu, mul_zero]
    rw [Finsupp.finset_sum_apply, Finset.sum_congr rfl this, Finset.sum_const_zero]
  · have hmem : α ∈ u.support := Finsupp.mem_support_iff.mpr hu
    have hsub : α.support ⊆ modes u := support_subset_modes hmem
    rw [dGamma_eq_sum _ (Finset.Subset.refl (modes u)), Finsupp.finset_sum_apply]
    have hterm : ∀ k ∈ modes u,
        creVec (diagCol lam k) (annA k u) α = ((lam k * (α k : ℝ) : ℝ) : ℂ) * u α := by
      intro k _
      rw [diagCol, creVec_single]
      simp only [Finsupp.smul_apply, smul_eq_mul, creA_annA_apply]
      push_cast
      ring
    rw [Finset.sum_congr rfl hterm, ← Finset.sum_mul, occEnergy]
    congr 1
    rw [← Complex.ofReal_sum]
    congr 1
    refine (Finset.sum_subset hsub fun k _ hk => ?_).symm
    have hzero : α k = 0 := by simpa using hk
    rw [hzero]
    simp
