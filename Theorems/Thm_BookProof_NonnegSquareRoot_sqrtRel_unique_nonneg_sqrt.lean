-- Generated from ChapterNonnegSquareRoot.lean — theorem BookProof.NonnegSquareRoot.sqrtRel_unique_nonneg_sqrt
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterClosureUniqueness
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Definitions.Def_ChapterA4
open BookProof.NonnegSquareRoot

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}



open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open scoped ComplexOrder


theorem BookProof.NonnegSquareRoot.sqrtRel_unique_nonneg_sqrt (hT : IsNonnegSelfAdjoint T) :
    IsNonnegSelfAdjoint (sqrtRel hT) ∧
      {p : F × F | ∃ w, (p.1, w) ∈ sqrtRel hT ∧ (w, p.2) ∈ sqrtRel hT} = (T : Set (F × F)) ∧
      ∀ S : Submodule ℂ (F × F), IsNonnegSelfAdjoint S →
        {p : F × F | ∃ w, (p.1, w) ∈ S ∧ (w, p.2) ∈ S} = (T : Set (F × F)) →
        S = sqrtRel hT := by sorry
