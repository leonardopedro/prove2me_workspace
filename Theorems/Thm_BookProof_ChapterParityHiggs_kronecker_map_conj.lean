-- Generated from ChapterParityHiggs.lean — theorem BookProof.ChapterParityHiggs.kronecker_map_conj
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterParityHiggs
open BookProof.ChapterParityHiggs


open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

theorem BookProof.ChapterParityHiggs.kronecker_map_conj {l m n p : Type*} (A : Matrix l m ℂ) (B : Matrix n p ℂ) :
    (A ⊗ₖ B).map (starRingEnd ℂ)
      = (A.map (starRingEnd ℂ)) ⊗ₖ (B.map (starRingEnd ℂ)) := by sorry
