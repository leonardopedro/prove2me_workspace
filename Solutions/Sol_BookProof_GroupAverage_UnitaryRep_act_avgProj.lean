-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.act_avgProj
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_apply
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_act_sum
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
theorem solution (h : G) (x : F) : rep.act h (rep.avgProj x) = rep.avgProj x := by

  rw [avgProj_apply, map_smul, rep.act_sum h x]
