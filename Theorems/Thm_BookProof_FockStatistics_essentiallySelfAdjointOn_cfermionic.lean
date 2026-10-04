-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.essentiallySelfAdjointOn_cfermionic
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterA
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterA4
open BookProof.ChapterA
open BookProof.ChapterA.System
open BookProof.ChapterMaschkeFiniteGroup
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

theorem BookProof.FockStatistics.essentiallySelfAdjointOn_cfermionic (n : ℕ) :
    EssentiallySelfAdjointOn (redDom (cfermionicProj Hs n) (fockSectorDom Hs D n))
      (cfermionicSectorOp Hs D A n) := by sorry
