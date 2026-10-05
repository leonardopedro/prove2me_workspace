-- Generated from ChapterSchurFiniteDimensional.lean — theorem BookProof.ChapterSchurFiniteDimensional.isSchurUnitary_of_irreducible_finiteDimensional
import Mathlib
import Definitions.Def_ChapterSchurFiniteDimensional
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurFiniteDimensional

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA


theorem BookProof.ChapterSchurFiniteDimensional.isSchurUnitary_of_irreducible_finiteDimensional [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : M.IsIrreducible) : IsSchurUnitary M := by sorry
