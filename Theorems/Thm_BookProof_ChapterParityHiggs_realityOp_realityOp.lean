-- Generated from ChapterParityHiggs.lean — theorem BookProof.ChapterParityHiggs.realityOp_realityOp
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterParityHiggs
open BookProof.ChapterParityHiggs


open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

theorem BookProof.ChapterParityHiggs.realityOp_realityOp {I : Type*} [Fintype I] [DecidableEq I]
    (M : Matrix I I ℂ) (v : I → ℂ) :
    realityOp M (realityOp M v) = (M * M.map (starRingEnd ℂ)) *ᵥ v := by sorry
