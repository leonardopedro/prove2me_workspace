-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.tmul_mem_corePow
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} {a : D₂} (ha : (a : Hs.carrier) ∈ D)
    {b : ((domSpace Hs D₂).pow n)} (hb : b ∈ corePow Hs D₂ D n) :
    a ⊗ₜ[ℂ] b ∈ corePow Hs D₂ D (n + 1) := Submodule.subset_span ⟨a, ha, b, hb, rfl⟩
