-- Generated from ChapterG.lean — theorem BookProof.ChapterG.expectation_gauge_invariant
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.expectation_gauge_invariant {V : Type*} [NormedAddCommGroup V]
    [InnerProductSpace ℂ V] [CompleteSpace V]
    (U : V →L[ℂ] V) (hU : U ∈ unitary (V →L[ℂ] V))
    (A : V →L[ℂ] V) (hA : A * U = U * A) (Ψ : V) :
    ⟪U Ψ, A (U Ψ)⟫_ℂ = ⟪Ψ, A Ψ⟫_ℂ := by sorry
