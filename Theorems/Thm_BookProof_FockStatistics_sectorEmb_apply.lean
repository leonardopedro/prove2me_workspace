-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.sectorEmb_apply
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.TensorCore
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

theorem BookProof.FockStatistics.sectorEmb_apply (n : ℕ) (x : (Hs.pow n).carrier) :
    sectorEmb Hs n x = (x : fockSector Hs n) := by sorry
