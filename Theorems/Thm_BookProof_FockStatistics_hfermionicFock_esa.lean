-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.hfermionicFock_esa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

theorem BookProof.FockStatistics.hfermionicFock_esa :
    EssentiallySelfAdjointOn (hfermionicFockDom Hs D) (hfermionicFockOp Hs D A) := by sorry
