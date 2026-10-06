-- Generated from ChapterParityHiggs.lean — theorem BookProof.ChapterParityHiggs.higgs_real_structure
import Definitions.Def_ChapterParity
import Mathlib
import Definitions.Def_ChapterParityHiggs
open BookProof.ChapterParityHiggs


open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

theorem BookProof.ChapterParityHiggs.higgs_real_structure (v : Fin 2 × Fin 2 → ℂ) :
    realityOp higgsReal (realityOp higgsReal v) = v := by sorry
