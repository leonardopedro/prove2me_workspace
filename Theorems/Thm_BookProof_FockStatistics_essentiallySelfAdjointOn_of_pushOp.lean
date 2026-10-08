-- Generated from ChapterFockStatisticsEsa.lean — theorem BookProof.FockStatistics.essentiallySelfAdjointOn_of_pushOp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFockStatisticsCompletion
open BookProof.GraphCore
open BookProof.FockStatistics



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm BookProof.PermSector
open BookProof.SecondQuantizationCore BookProof.EsaOneParticle BookProof.DirectSumEsa

noncomputable section

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]

theorem BookProof.FockStatistics.essentiallySelfAdjointOn_of_pushOp (U : F →ₗᵢ[ℂ] G) {D : Submodule ℂ F}
    (T : D →ₗ[ℂ] F) (h : EssentiallySelfAdjointOn (pushDom U D) (pushOp U T)) :
    EssentiallySelfAdjointOn D T := by sorry
