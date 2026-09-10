-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.annih_basis
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
    annih m (fockBasis n) = ((Real.sqrt (n m) : ℝ) : ℂ) • fockBasis (n - Finsupp.single m 1) := by

  ext k
  rcases eq_or_ne (k + Finsupp.single m 1) n with hk | hk
  · have hkm : k = n - Finsupp.single m 1 := by
      rw [← hk, add_single_sub_single]
    have hnm : (n m : ℝ) = (k m : ℝ) + 1 := by
      rw [← hk]; push_cast; simp
    subst hkm
    simp [annih_coe, fockBasis_coe, hk, hnm]
  · have hkne : k ≠ n - Finsupp.single m 1 ∨ (n m) = 0 := by
      by_contra hcon
      push_neg at hcon
      obtain ⟨hk1, hk2⟩ := hcon
      apply hk
      rw [hk1]
      exact sub_single_add_single (by omega)
    simp only [annih_coe, fockBasis_coe, hk, if_false, mul_zero, Submodule.coe_smul]
    rcases hkne with h | h
    · simp [fockBasis_coe, h]
    · simp [h]
