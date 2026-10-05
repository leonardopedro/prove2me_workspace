-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.inclPow_top_surjective
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa
open BookProof.ScalarDGamma




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : Function.Surjective (inclPow Hs ⊤ n) := by

  induction n with
  | zero => exact fun x => ⟨x, rfl⟩
  | succ n ih =>
      have h1 : Function.Surjective ((⊤ : Submodule ℂ Hs.carrier).subtype) :=
        fun x => ⟨⟨x, trivial⟩, rfl⟩
      exact TensorProduct.map_surjective h1 ih
