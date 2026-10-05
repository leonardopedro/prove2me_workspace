-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.sectorOp_scalar
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
import Theorems.Thm_BookProof_ScalarDGamma_derPow_scalar
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (x : sectorDom Hs ⊤ n) :
    sectorOp Hs ⊤ (scalarOp Hs c) n x = ((n : ℂ) * c) • (x : (Hs.pow n).carrier) := by

  obtain ⟨x₀, hx₀⟩ := x.2
  have hx : (x : (Hs.pow n).carrier) = inclPow Hs ⊤ n x₀ := hx₀.symm
  rw [sectorOp_apply Hs ⊤ _ n x x₀ hx, derPow_scalar, hx]
