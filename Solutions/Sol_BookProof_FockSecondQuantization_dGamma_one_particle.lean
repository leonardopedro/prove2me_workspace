-- Generated from ChapterFockSecondQuantization.lean — solution of BookProof.FockSecondQuantization.dGamma_one_particle
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
import Theorems.Thm_BookProof_FockSecondQuantization_up_self
import Theorems.Thm_BookProof_FockSecondQuantization_up_of_ne
import Theorems.Thm_BookProof_FockSecondQuantization_dn_self
import Theorems.Thm_BookProof_FockSecondQuantization_dn_of_ne
import Theorems.Thm_BookProof_FockSecondQuantization_annA_single
import Theorems.Thm_BookProof_FockSecondQuantization_creA_single
import Theorems.Thm_BookProof_FockSecondQuantization_creVec_apply
import Theorems.Thm_BookProof_FockSecondQuantization_dGamma_single
open BookProof.FockSecondQuantization








open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (col : ℕ → (ℕ →₀ ℂ)) (k : ℕ) :
    dGamma col (Finsupp.single (Finsupp.single k 1) 1)
      = ∑ j ∈ (col k).support, (col k) j • Finsupp.single (Finsupp.single j 1) (1 : ℂ) := by

  classical
  have hup : ∀ j : ℕ, up j (0 : Conf) = Finsupp.single j 1 := by
    intro j
    refine Finsupp.ext fun i => ?_
    by_cases h : i = j
    · subst h; simp
    · rw [up_of_ne _ h]
      simp [h]
  have hsupp : (Finsupp.single k 1 : Conf).support = {k} :=
    Finsupp.support_single_ne_zero k one_ne_zero
  have hdn : dn k (Finsupp.single k 1 : Conf) = 0 := by
    refine Finsupp.ext fun i => ?_
    by_cases h : i = k
    · subst h; simp
    · rw [dn_of_ne _ h]
      simp [h]
  rw [dGamma_single, hsupp]
  have hann : annA k (Finsupp.single (Finsupp.single k 1 : Conf) (1 : ℂ))
      = Finsupp.single (0 : Conf) (1 : ℂ) := by
    rw [annA_single, hdn]
    simp
  rw [Finset.sum_singleton, hann, one_smul, creVec_apply]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [creA_single, hup j]
  simp
