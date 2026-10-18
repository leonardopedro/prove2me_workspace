-- Generated from ChapterFockStatisticsEsa.lean — solution of BookProof.FockStatistics.essentiallySelfAdjointOn_fermionic_core_of_esa
import Mathlib
import Definitions.Def_ChapterFockStatisticsEsa
import Theorems.Thm_BookProof_FockStatistics_essentiallySelfAdjointOn_sectorDom_of_esa
import Theorems.Thm_BookProof_PermSector_essentiallySelfAdjointOn_fermionic_core
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterEsaOneParticleDGamma
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterFockStatisticsCompletion
open BookProof.FockStatistics




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm BookProof.PermSector
open BookProof.SecondQuantizationCore BookProof.EsaOneParticle BookProof.DirectSumEsa
open BookProof.DirectSumEsa
open BookProof.GraphCore
open BookProof.TensorCore

noncomputable section

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
variable (D₀ : Submodule ℂ Hs.carrier)
variable {D₀ : Submodule ℂ Hs.carrier}

set_option maxHeartbeats 1000000 in
include hdense hesa hsym in
theorem solution (hcore : IsGraphCore D₀ A) (n : ℕ) :
    EssentiallySelfAdjointOn (redDom (fermionicProj Hs n) (sectorCore Hs D D₀ n))
      (fermionicCoreOp Hs D A D₀ n) :=
  essentiallySelfAdjointOn_fermionic_core Hs D A D₀ n hcore
      (essentiallySelfAdjointOn_sectorDom_of_esa A hdense hsym hesa n)
