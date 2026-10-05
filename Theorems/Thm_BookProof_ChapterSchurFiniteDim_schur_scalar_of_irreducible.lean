-- Generated from ChapterSchurFiniteDim.lean — theorem BookProof.ChapterSchurFiniteDim.schur_scalar_of_irreducible
import Mathlib
import Definitions.Def_ChapterSchurFiniteDim
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterSchurFiniteDim

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open Module


open BookProof.ChapterA


theorem BookProof.ChapterSchurFiniteDim.schur_scalar_of_irreducible [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : IsIrreducibleSystem M) (f : V →ₗ[ℂ] V)
    (hf : ∀ m ∈ M.ops, ∀ x, f (m x) = m (f x)) :
    ∃ c : ℂ, ∀ x, f x = c • x := by sorry
