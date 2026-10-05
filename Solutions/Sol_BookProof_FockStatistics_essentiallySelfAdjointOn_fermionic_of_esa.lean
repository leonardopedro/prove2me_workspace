-- Generated from ChapterFockStatisticsEsa.lean — solution of BookProof.FockStatistics.essentiallySelfAdjointOn_fermionic_of_esa
import Mathlib
import Definitions.Def_ChapterFockStatisticsEsa
import Theorems.Thm_BookProof_FockStatistics_essentiallySelfAdjointOn_sectorDom_of_esa
import Theorems.Thm_BookProof_PermSector_essentiallySelfAdjointOn_fermionic
open BookProof.FockStatistics




open scoped TensorProduct ENNReal
open BookProof.FarisLavine BookProof.GraphCore BookProof.ReducedEsa BookProof.TensorCore
open BookProof.GroupAverage BookProof.TensorPerm BookProof.PermSector
open BookProof.SecondQuantizationCore BookProof.EsaOneParticle BookProof.DirectSumEsa

noncomputable section

variable {F G : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G]
variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
  (A : D →ₗ[ℂ] Hs.carrier) (hdense : Dense (D : Set Hs.carrier)) (hsym : SymmetricOn D A)
  (hesa : EssentiallySelfAdjointOn D A)
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
variable (D₀ : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    EssentiallySelfAdjointOn (redDom (fermionicProj Hs n) (sectorDom Hs D n))
      (fermionicSectorOp Hs D A n) :=
  essentiallySelfAdjointOn_fermionic Hs D A n
      (essentiallySelfAdjointOn_sectorDom_of_esa A hdense hsym hesa n)
