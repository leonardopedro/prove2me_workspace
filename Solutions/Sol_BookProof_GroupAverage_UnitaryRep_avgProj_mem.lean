-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.avgProj_mem
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
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
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (hD : ∀ (g : G) (x : F), x ∈ D → rep.act g x ∈ D) :
    ∀ x ∈ D, rep.avgProj x ∈ D := by

  intro x hx
  rw [avgProj_apply]
  exact Submodule.smul_mem _ _ (Submodule.sum_mem _ (fun g _ => hD g x hx))
