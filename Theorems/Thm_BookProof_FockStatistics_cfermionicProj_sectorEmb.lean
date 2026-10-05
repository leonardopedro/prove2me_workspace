-- Generated from ChapterFockStatisticsCompletion.lean — theorem BookProof.FockStatistics.cfermionicProj_sectorEmb
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterGaugeUnconstrainedSpectrum
import Definitions.Def_ChapterMaschkeFiniteGroup
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterWignerLittleGroup
open BookProof.ChapterGaugeUnconstrainedSpectrum
open BookProof.ChapterMaschkeFiniteGroup
open BookProof.TensorCore
open BookProof.ChapterWignerLittleGroup
open BookProof.GroupAverage.UnitaryRep
open BookProof.FockStatistics

variable {G : Type*} [Group G] [Fintype G] {F : Type*} [NormedAddCommGroup F]
  [InnerProductSpace ℂ F]
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)



open BookProof.GroupAverage BookProof.ReducedEsa

noncomputable section

theorem BookProof.FockStatistics.cfermionicProj_sectorEmb (n : ℕ) (x : (Hs.pow n).carrier) :
    cfermionicProj Hs n (sectorEmb Hs n x) = sectorEmb Hs n (fermionicProj Hs n x) := by sorry
