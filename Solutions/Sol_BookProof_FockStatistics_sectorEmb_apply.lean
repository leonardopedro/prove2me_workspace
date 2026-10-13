-- Generated from ChapterFockStatisticsCompletion.lean — solution of BookProof.FockStatistics.sectorEmb_apply
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics




open BookProof.GroupAverage BookProof.ReducedEsa
open BookProof.TensorCore

noncomputable section

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : (Hs.pow n).carrier) :
    sectorEmb Hs n x = (x : fockSector Hs n) := rfl
