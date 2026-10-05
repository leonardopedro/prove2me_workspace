-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.avgProj_of_invariant
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_card_ne_zero
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_apply
open BookProof.GroupAverage
open BookProof.GroupAverage.UnitaryRep




open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)
variable (G) in

set_option maxHeartbeats 1000000 in
theorem solution {x : F} (hx : ∀ g : G, rep.act g x = x) : rep.avgProj x = x := by

  rw [avgProj_apply]
  simp only [hx]
  rw [Finset.sum_const, Finset.card_univ, ← Nat.cast_smul_eq_nsmul ℂ,
    smul_smul, inv_mul_cancel₀ (card_ne_zero G), one_smul]
