-- Generated from ChapterParityHiggs.lean — theorem BookProof.ChapterParityHiggs.pseudoreal_kron_pseudoreal_real
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterParityHiggs
open BookProof.ChapterParityHiggs


open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

theorem BookProof.ChapterParityHiggs.pseudoreal_kron_pseudoreal_real
    {m n : Type*} [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n]
    (A : Matrix m m ℂ) (B : Matrix n n ℂ)
    (hA : A * A.map (starRingEnd ℂ) = -1) (hB : B * B.map (starRingEnd ℂ) = -1) :
    (A ⊗ₖ B) * ((A ⊗ₖ B).map (starRingEnd ℂ)) = 1 := by sorry
