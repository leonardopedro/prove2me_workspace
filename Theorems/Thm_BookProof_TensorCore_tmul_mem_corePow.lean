-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.tmul_mem_corePow
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
open BookProof.TensorCore

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

theorem BookProof.TensorCore.tmul_mem_corePow {n : ℕ} {a : D₂} (ha : (a : Hs.carrier) ∈ D)
    {b : ((domSpace Hs D₂).pow n)} (hb : b ∈ corePow Hs D₂ D n) :
    a ⊗ₜ[ℂ] b ∈ corePow Hs D₂ D (n + 1) := by sorry
