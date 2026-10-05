-- Generated from ChapterA3w.lean — solution of BookProof.ChapterA3w.weyl_invariant_complement
import Mathlib
import Definitions.Def_ChapterA3w
open BookProof.ChapterA3w



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3q

set_option maxHeartbeats 1000000 in
theorem solution (h : WeylCompleteReducibility)
    {V : Type} [AddCommGroup V] [Module ℂ V] [Module.Finite ℂ V]
    (ρ : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V)
    (W : Submodule ℂ V)
    (hW : ∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W, ρ g x ∈ W) :
    ∃ W' : Submodule ℂ V,
      (∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W', ρ g x ∈ W') ∧ IsCompl W W' := h ρ W hW
