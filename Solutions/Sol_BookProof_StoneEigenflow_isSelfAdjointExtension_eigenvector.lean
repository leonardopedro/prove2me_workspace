-- Generated from ChapterStoneEigenflow.lean — solution of BookProof.StoneEigenflow.isSelfAdjointExtension_eigenvector
import Mathlib
import Definitions.Def_ChapterStoneEigenflow
open BookProof.StoneEigenflow



open scoped InnerProductSpace


open BookProof.ChapterUnitaryTransport BookProof.EsaClosure BookProof.FarisLavine
open BookProof.ChapterStoneResolvent BookProof.StoneBridge

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution {D Dom : Submodule ℂ F} {Hc : D →ₗ[ℂ] F}
    {A : Dom →ₗ[ℂ] F} (h : IsSelfAdjointExtension Hc A) (x : D) {lam : ℂ}
    (hx : Hc x = lam • (x : F)) :
    ∃ hmem : (x : F) ∈ Dom, A ⟨(x : F), hmem⟩ = lam • (x : F) := by

  obtain ⟨hmem, heq⟩ := h.1 x
  exact ⟨hmem, by rw [heq, hx]⟩
