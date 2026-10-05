-- Generated from ChapterG.lean — theorem BookProof.ChapterG.shift_invariant_l2_eq_zero
import Mathlib
import Definitions.Def_ChapterG
open BookProof.ChapterG


open scoped ComplexConjugate InnerProductSpace Matrix

theorem BookProof.ChapterG.shift_invariant_l2_eq_zero (Ψ : lp (fun _ : ℤ => ℂ) 2)
    (hΨ : ∀ k, Ψ (k + 1) = Ψ k) : Ψ = 0 := by sorry
