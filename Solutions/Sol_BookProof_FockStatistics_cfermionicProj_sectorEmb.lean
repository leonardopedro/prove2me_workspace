-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.cfermionicProj_sectorEmb
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_avgProj_apply
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics




open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : (Hs.pow n).carrier) :
    cfermionicProj Hs n (sectorEmb Hs n x) = sectorEmb Hs n (fermionicProj Hs n x) := by

  rw [cfermionicProj, UnitaryRep.avgProj_apply, fermionicProj, UnitaryRep.avgProj_apply,
    map_smul, map_sum]
  congr 1
  exact Finset.sum_congr rfl (fun g _ => (signRep Hs n).completionRep_act_coe g x)
