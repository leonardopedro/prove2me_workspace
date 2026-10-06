-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.graphPow_tmul_mem_closure
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore
open BookProof.TensorCore

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

theorem BookProof.TensorCore.graphPow_tmul_mem_closure (hcore : IsGraphCore D A) (n : ℕ)
    (ih : ∀ b : ((domSpace Hs D₂).pow n), graphPow Hs D₂ A n b ∈
      (Submodule.map (graphPow Hs D₂ A n) (corePow Hs D₂ D n)).topologicalClosure)
    (a : D₂) (b : ((domSpace Hs D₂).pow n)) :
    graphPow Hs D₂ A (n + 1) (a ⊗ₜ[ℂ] b) ∈
      (Submodule.map (graphPow Hs D₂ A (n + 1))
        (corePow Hs D₂ D (n + 1))).topologicalClosure := by sorry
