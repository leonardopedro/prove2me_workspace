-- Generated from ChapterSchurIrreducible.lean — solution of BookProof.ChapterSchurIrreducible.isSchurFull_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurIrreducible
import Theorems.Thm_BookProof_ChapterSchurIrreducible_commutant_scalar_of_irreducible
open BookProof.ChapterSchurIrreducible



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) (hM : M.IsNormal)
    (hirr : M.IsIrreducible) : IsSchurFull M := fun _ hS => commutant_scalar_of_irreducible M hM hirr hS
