-- Generated from ChapterFockStatisticsEsa.lean — theorem BookProof.FockStatistics.bosonicFock_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterDirectSumEsa
import Mathlib
import Definitions.Def_ChapterFockStatisticsEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterScalarDGammaEsa
open BookProof.TensorCore



open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.TensorPerm BookProof.PermSector
open BookProof.SecondQuantizationCore BookProof.DirectSumEsa

noncomputable section

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
variable (D₀ : Submodule ℂ Hs.carrier)
variable {D₀ : Submodule ℂ Hs.carrier}
  (D₀ : Submodule ℂ Hs.carrier)

include hsym in
theorem BookProof.FockStatistics.bosonicFock_symmetricOn :
    SymmetricOn (bosonicFockDom Hs D) (bosonicFockOp Hs D A) := by sorry
