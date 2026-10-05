-- Generated from ChapterTensorSumEsa.lean — theorem BookProof.TensorSumEsa.exists_pair_of_mem_pairCorePoly
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorSumEsa
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore
open BookProof.TensorSumEsa

variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
variable (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
variable {Hs Ks : IPSpace} {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier}
  {A : DA →ₗ[ℂ] Hs.carrier} {B : DB →ₗ[ℂ] Ks.carrier}
variable (P : OneParticleFlow Hs DA A) (Q : OneParticleFlow Ks DB B)
variable {Hs Ks : IPSpace} [CompleteSpace Hs.carrier] [CompleteSpace Ks.carrier]
variable (Hs Ks : IPSpace) (DA : Submodule ℂ Hs.carrier) (DB : Submodule ℂ Ks.carrier)
  (A : DA →ₗ[ℂ] Hs.carrier) (B : DB →ₗ[ℂ] Ks.carrier)
  (CA : Submodule ℂ Hs.carrier) (CB : Submodule ℂ Ks.carrier)
variable {Hs Ks : IPSpace}



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

theorem BookProof.TensorSumEsa.exists_pair_of_mem_pairCorePoly {DA' : Submodule ℂ Hs.carrier}
    {DB' : Submodule ℂ Ks.carrier} (A' : DA' →ₗ[ℂ] Hs.carrier) (B' : DB' →ₗ[ℂ] Ks.carrier)
    {DA : Submodule ℂ Hs.carrier} {DB : Submodule ℂ Ks.carrier} (A : DA →ₗ[ℂ] Hs.carrier)
    (B : DB →ₗ[ℂ] Ks.carrier) (hleA : DA ≤ DA') (hleB : DB ≤ DB')
    (hextA : ∀ v : DA, A' ⟨(v : Hs.carrier), hleA v.2⟩ = A v)
    (hextB : ∀ v : DB, B' ⟨(v : Ks.carrier), hleB v.2⟩ = B v)
    (y : DA' ⊗[ℂ] DB') (hy : y ∈ pairCorePoly Hs Ks DA' DB' DA DB) :
    ∃ y' : DA ⊗[ℂ] DB,
      inclPair Hs Ks DA DB y' = inclPair Hs Ks DA' DB' y ∧
        sumPoly Hs Ks DA DB A B y' = sumPoly Hs Ks DA' DB' A' B' y := by sorry
