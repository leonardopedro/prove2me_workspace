-- Generated from ChapterTensorGraphCore.lean — theorem BookProof.TensorCore.graphPow_range_le_closure
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterGraphCoreTransfer
open BookProof.GraphCore
open BookProof.TensorCore



open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore

noncomputable section

variable (Hs : IPSpace) (D₂ : Submodule ℂ Hs.carrier)
variable (A : D₂ →ₗ[ℂ] Hs.carrier)
variable (D : Submodule ℂ Hs.carrier)

theorem BookProof.TensorCore.graphPow_range_le_closure (hcore : IsGraphCore D A) (n : ℕ) :
    LinearMap.range (graphPow Hs D₂ A n)
      ≤ (Submodule.map (graphPow Hs D₂ A n) (corePow Hs D₂ D n)).topologicalClosure := by sorry
