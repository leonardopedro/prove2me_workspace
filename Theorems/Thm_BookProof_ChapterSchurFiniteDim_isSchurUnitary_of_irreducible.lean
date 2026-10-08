-- Generated from ChapterSchurFiniteDim.lean — theorem BookProof.ChapterSchurFiniteDim.isSchurUnitary_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurFiniteDim
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurFiniteDim


open Module


open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurFiniteDim.isSchurUnitary_of_irreducible [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : IsIrreducibleSystem M) :
    IsSchurUnitary M := by sorry
