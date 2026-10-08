-- Generated from ChapterH3.lean — theorem BookProof.ChapterH3.sirk_krylov_mem_adjoin
import Mathlib
import Definitions.Def_ChapterH3
open BookProof.ChapterH3


open scoped BigOperators
open intervalIntegral


noncomputable section

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

theorem BookProof.ChapterH3.sirk_krylov_mem_adjoin
    (Xm : Module.End ℂ E) (Y X : ℕ → Module.End ℂ E)
    (hX : ∀ j, X j = Y j * Xm) (v : E) (j : ℕ) :
    ∃ r ∈ Algebra.adjoin ℂ ({Xm} ∪ Set.range Y),
      sirkKrylov X v j = r v := by sorry
