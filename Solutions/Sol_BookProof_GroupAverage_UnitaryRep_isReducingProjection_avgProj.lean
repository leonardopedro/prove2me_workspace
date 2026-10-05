-- Generated from ChapterGroupAverageEsa.lean — solution of BookProof.GroupAverage.UnitaryRep.isReducingProjection_avgProj
import Mathlib
import Definitions.Def_ChapterGroupAverageEsa
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_inner_act_left
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_apply
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
theorem solution : IsReducingProjection rep.avgProj where
  idem x :=
  where
    idem x := rep.avgProj_of_invariant (fun g => rep.act_avgProj g x)
    symm x y := by
      rw [avgProj_apply, avgProj_apply, inner_smul_left, inner_smul_right,
        map_inv₀, Complex.conj_natCast, sum_inner, inner_sum]
      congr 1
      refine Fintype.sum_bijective (fun g : G => g⁻¹) (Equiv.inv G).bijective _ _ (fun g => ?_)
      exact rep.inner_act_left g x y
