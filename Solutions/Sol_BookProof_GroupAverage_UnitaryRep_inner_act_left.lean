-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.inner_act_left
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.GroupAverage
open BookProof.GroupAverage.UnitaryRep




open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {G : Type*} [Group G] [Fintype G]
variable (rep : UnitaryRep G F)

set_option maxHeartbeats 1000000 in
theorem solution (g : G) (x y : F) :
    (inner ℂ (rep.act g x) y : ℂ) = inner ℂ x (rep.act g⁻¹ y) := by

  have h := rep.act_inner g x (rep.act g⁻¹ y)
  rw [← rep.act_mul, mul_inv_cancel, rep.act_one] at h
  exact h
