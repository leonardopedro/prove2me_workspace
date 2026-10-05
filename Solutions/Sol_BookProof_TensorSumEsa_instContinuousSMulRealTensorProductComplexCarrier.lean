-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.instContinuousSMulRealTensorProductComplexCarrier
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
open BookProof.TensorSumEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)

set_option maxHeartbeats 1000000 in
def pflow (t : ℝ) : (DA ⊗[ℂ] DB) →ₗ[ℂ] (DA ⊗[ℂ] DB) := by

  haveI : IsBoundedSMul ℝ (Hs.carrier ⊗[ℂ] Ks.carrier) := NormedSpace.toIsBoundedSMul
  exact IsBoundedSMul.continuousSMul
