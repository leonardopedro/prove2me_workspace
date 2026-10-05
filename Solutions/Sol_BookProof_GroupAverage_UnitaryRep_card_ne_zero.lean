-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.card_ne_zero
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
variable (G) in

set_option maxHeartbeats 1000000 in
theorem solution : (Fintype.card G : ℂ) ≠ 0 := by

  have : 0 < Fintype.card G := Fintype.card_pos
  exact_mod_cast Nat.cast_ne_zero.mpr this.ne'
