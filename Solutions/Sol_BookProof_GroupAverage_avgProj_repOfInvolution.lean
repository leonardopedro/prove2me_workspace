-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.avgProj_repOfInvolution
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_apply
import Theorems.Thm_BookProof_GroupAverage_univ_two
open BookProof.GroupAverage




open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)
variable {D : Submodule ℂ F}
variable {T : D →ₗ[ℂ] F}

set_option maxHeartbeats 1000000 in
theorem solution (U : F →ₗ[ℂ] F) (hU2 : ∀ x, U (U x) = x)
    (hUi : ∀ x y : F, (inner ℂ (U x) (U y) : ℂ) = inner ℂ x y) (x : F) :
    (repOfInvolution U hU2 hUi).avgProj x = symProj U x := by

  have hne : (1 : Multiplicative (ZMod 2)) ≠ Multiplicative.ofAdd 1 := by decide
  have hcard : (Fintype.card (Multiplicative (ZMod 2)) : ℂ) = 2 := by simp
  rw [UnitaryRep.avgProj_apply, univ_two, Finset.sum_pair hne, hcard]
  have h1 : (repOfInvolution U hU2 hUi).act 1 x = x := by simp [repOfInvolution]
  have h2 : (repOfInvolution U hU2 hUi).act (Multiplicative.ofAdd 1) x = U x := by
    simp [repOfInvolution, hne.symm]
  rw [h1, h2]
  simp [symProj]
