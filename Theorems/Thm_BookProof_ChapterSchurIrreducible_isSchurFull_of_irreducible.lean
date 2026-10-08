-- Generated from ChapterSchurIrreducible.lean — theorem BookProof.ChapterSchurIrreducible.isSchurFull_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurIrreducible


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurIrreducible.isSchurFull_of_irreducible (M : System ℂ V) (hM : M.IsNormal)
    (hirr : M.IsIrreducible) : IsSchurFull M := by sorry
