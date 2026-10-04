-- Generated from ChapterA3w.lean — theorem BookProof.ChapterA3w.weyl_invariant_complement
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3j
import Definitions.Def_ChapterA3k
import Mathlib
import Definitions.Def_ChapterA3w
import Definitions.Def_ChapterA4
open BookProof.ChapterA3w


open Matrix


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3q

theorem BookProof.ChapterA3w.weyl_invariant_complement (h : WeylCompleteReducibility)
    {V : Type} [AddCommGroup V] [Module ℂ V] [Module.Finite ℂ V]
    (ρ : Representation ℂ (Matrix.SpecialLinearGroup (Fin 2) ℂ) V)
    (W : Submodule ℂ V)
    (hW : ∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W, ρ g x ∈ W) :
    ∃ W' : Submodule ℂ V,
      (∀ g : Matrix.SpecialLinearGroup (Fin 2) ℂ, ∀ x ∈ W', ρ g x ∈ W') ∧ IsCompl W W' := by sorry
