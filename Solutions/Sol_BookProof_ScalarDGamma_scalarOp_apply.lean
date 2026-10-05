-- Generated from ChapterScalarDGammaEsa.lean — solution of BookProof.ScalarDGamma.scalarOp_apply
import Mathlib
import Definitions.Def_ChapterScalarDGammaEsa




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore

noncomputable section

variable (Hs : IPSpace) (c : ℝ)

variable (Hs : IPSpace) (c : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (x : (⊤ : Submodule ℂ Hs.carrier)) :
    scalarOp Hs c x = (c : ℂ) • (x : Hs.carrier) := rfl
