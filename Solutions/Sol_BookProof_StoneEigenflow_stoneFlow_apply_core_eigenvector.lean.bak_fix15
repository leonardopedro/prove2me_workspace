-- Generated from ChapterStoneEigenflow.lean — solution of BookProof.StoneEigenflow.stoneFlow_apply_core_eigenvector
import Mathlib
import Definitions.Def_ChapterStoneEigenflow
import Theorems.Thm_BookProof_StoneEigenflow_isSelfAdjointExtension_eigenvector
import Theorems.Thm_BookProof_StoneEigenflow_stoneFlow_apply_eigenvector
open BookProof.StoneEigenflow



open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.EsaClosure BookProof.FarisLavine
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {T : UnboundedSelfAdjoint F} {U : ℝ → (F →L[ℂ] F)}
    (hext : IsSelfAdjointExtension Hc T.op) (hU : IsStoneFlow T U) (x : D) {lam : ℝ}
    (hx : Hc x = (lam : ℂ) • (x : F)) (t : ℝ) :
    U t (x : F) = Complex.exp (-(Complex.I * lam * t)) • (x : F) := by

  obtain ⟨hmem, heq⟩ := isSelfAdjointExtension_eigenvector hext x hx
  exact stoneFlow_apply_eigenvector hU hmem heq t
