-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.cbosonicProj_sectorEmb
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterGroupAverageEsa
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)

theorem BookProof.FockStatistics.cbosonicProj_sectorEmb (n : ℕ) (x : (Hs.pow n).carrier) :
    cbosonicProj Hs n (sectorEmb Hs n x) = sectorEmb Hs n (bosonicProj Hs n x) := by sorry
