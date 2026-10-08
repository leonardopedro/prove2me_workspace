-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.hbosonicFock_esa
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.TensorCore
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)

theorem BookProof.FockStatistics.hbosonicFock_esa :
    EssentiallySelfAdjointOn (hbosonicFockDom Hs D) (hbosonicFockOp Hs D A) := by sorry
