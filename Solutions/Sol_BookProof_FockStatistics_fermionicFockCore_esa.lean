-- Generated from ChapterFockStatisticsEsa.lean — solution of BookProof.FockStatistics.fermionicFockCore_esa
import Mathlib
import Definitions.Def_ChapterFockStatisticsEsa
import Theorems.Thm_BookProof_FockStatistics_essentiallySelfAdjointOn_fermionic_core_of_esa
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
variable {D₀ : Submodule ℂ Hs.carrier}
variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
  (D₀ : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution (hcore : IsGraphCore D₀ A) :
    EssentiallySelfAdjointOn (fermionicFockCoreDom Hs D D₀) (fermionicFockCoreOp Hs D A D₀) :=
  dsOp_essentiallySelfAdjointOn _
      (fun n => essentiallySelfAdjointOn_fermionic_core_of_esa A hdense hsym hesa hcore n)
