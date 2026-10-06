-- Generated from ChapterFockStatisticsEsa.lean — solution of BookProof.FockStatistics.bosonicFockOp_single
import Mathlib
import Definitions.Def_ChapterFockStatisticsEsa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_single
import Theorems.Thm_BookProof_DirectSumEsa_single_mem_dsCore
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
theorem solution (n : ℕ)
    (u : redDom (bosonicProj Hs n) (sectorDom Hs D n)) :
    (bosonicFockOp Hs D A ⟨lp.single 2 n ((u : sector (bosonicProj Hs n))),
        single_mem_dsCore (D := fun n : ℕ => redDom (bosonicProj Hs n) (sectorDom Hs D n))
          n u⟩ : bosonicFock Hs)
      = lp.single 2 n (bosonicSectorOp Hs D A n u) := dsOp_single (fun n : ℕ => bosonicSectorOp Hs D A n) n u
