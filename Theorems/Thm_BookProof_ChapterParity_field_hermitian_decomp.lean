-- Generated from ChapterParity.lean — theorem BookProof.ChapterParity.field_hermitian_decomp
import Mathlib
import Definitions.Def_ChapterParity
open BookProof.ChapterParity

variable {n : Type*}


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterParity.field_hermitian_decomp (X : Matrix n n ℂ) :
    X = hermPart X + Complex.I • antihermPart X := by sorry
