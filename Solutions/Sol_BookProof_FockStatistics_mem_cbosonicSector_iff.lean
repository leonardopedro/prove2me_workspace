-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.mem_cbosonicSector_iff
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Theorems.Thm_BookProof_GroupAverage_UnitaryRep_mem_range_avgProj_iff
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics




open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) {x : fockSector Hs n} :
    x ∈ sector (cbosonicProj Hs n) ↔ ∀ σ : Equiv.Perm (Fin n), (cpermRep Hs n).act σ x = x := (cpermRep Hs n).mem_range_avgProj_iff
