-- Generated from ChapterTensorSumEsa.lean — solution of BookProof.TensorSumEsa.mem_span_tmul
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
theorem solution (x : DA ⊗[ℂ] DB) :
    x ∈ Submodule.span ℂ {t : DA ⊗[ℂ] DB | ∃ (p : DA) (q : DB), p ⊗ₜ[ℂ] q = t} := by

  rw [TensorProduct.span_tmul_eq_top]; trivial
