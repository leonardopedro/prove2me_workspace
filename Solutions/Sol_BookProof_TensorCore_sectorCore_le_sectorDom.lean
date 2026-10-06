-- Generated from ChapterTensorGraphCore.lean — solution of BookProof.TensorCore.sectorCore_le_sectorDom
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
theorem solution (n : ℕ) :
    sectorCore Hs D₂ D n ≤ sectorDom Hs D₂ n := by

  rintro x ⟨y, -, rfl⟩
  exact ⟨y, rfl⟩
