-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.restrictToTop_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution (H : F →ₗ[ℂ] F) (v : (⊤ : Submodule ℂ F)) :
    (restrictToTop H v : F) = H (v : F) := rfl
