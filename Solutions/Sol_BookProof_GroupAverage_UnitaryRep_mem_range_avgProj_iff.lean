-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.mem_range_avgProj_iff
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_act_avgProj
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_of_invariant
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
theorem solution {x : F} :
    x ∈ LinearMap.range rep.avgProj ↔ ∀ g : G, rep.act g x = x := by

  constructor
  · rintro ⟨u, rfl⟩ g
    exact rep.act_avgProj g u
  · intro hx
    exact ⟨x, rep.avgProj_of_invariant hx⟩
