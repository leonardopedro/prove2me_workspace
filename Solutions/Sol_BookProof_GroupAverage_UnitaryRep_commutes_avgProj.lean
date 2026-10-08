-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.commutes_avgProj
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_apply
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_mem
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
variable {T : D →ₗ[ℂ] F}

set_option maxHeartbeats 1000000 in
theorem solution {hD : ∀ (g : G) (x : F), x ∈ D → rep.act g x ∈ D}
    (hT : ∀ (g : G) (x : D), T ⟨rep.act g (x : F), hD g _ x.2⟩ = rep.act g (T x)) :
    Commutes T (rep.avgProj_mem hD) where
  comm x :=
  where
    comm x := by
      have hsplit : (⟨rep.avgProj (x : F), rep.avgProj_mem hD _ x.2⟩ : D)
          = ((Fintype.card G : ℂ))⁻¹ • ∑ g : G, (⟨rep.act g (x : F), hD g _ x.2⟩ : D) := by
        apply Subtype.ext
        simp [avgProj_apply]
      rw [hsplit, map_smul, map_sum, avgProj_apply]
      congr 1
      exact Finset.sum_congr rfl (fun g _ => hT g x)
