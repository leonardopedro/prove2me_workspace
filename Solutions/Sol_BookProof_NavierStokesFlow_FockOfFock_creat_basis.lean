-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.creat_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_fockBasis_coe
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_add_single_sub_single
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open FullEsa



variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution (m : M) (n : Conf M) :
    creat m (fockBasis n)
      = ((Real.sqrt (n m + 1) : ℝ) : ℂ) • fockBasis (n + Finsupp.single m 1) := by

  ext k
  rcases eq_or_ne k (n + Finsupp.single m 1) with rfl | hk
  · have h1 : (n + Finsupp.single m 1 : Conf M) - Finsupp.single m 1 = n :=
      add_single_sub_single m n
    have h2 : ((n + Finsupp.single m 1 : Conf M) m : ℝ) = (n m : ℝ) + 1 := by push_cast; simp
    simp [creat_coe, fockBasis_coe, h1]
  · have hne : k - Finsupp.single m 1 ≠ n ∨ k m = 0 := by
      by_contra hcon
      push_neg at hcon
      obtain ⟨h1, h2⟩ := hcon
      apply hk
      rw [← h1]
      exact (sub_single_add_single (by omega)).symm
    simp only [creat_coe, fockBasis_coe, Submodule.coe_smul]
    have hr : (((fockBasis (n + Finsupp.single m 1) : FockDom M) : FockL2 M) : Conf M → ℂ) k = 0
        := by
      rw [fockBasis_coe, if_neg hk]
    rcases hne with h | h
    · rw [if_neg h, mul_zero]
      simp [hr]
    · rw [h]
      simp [hr]
