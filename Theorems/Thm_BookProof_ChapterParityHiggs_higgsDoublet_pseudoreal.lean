-- Generated from ChapterParityHiggs.lean — theorem BookProof.ChapterParityHiggs.higgsDoublet_pseudoreal
import Mathlib
import Definitions.Def_ChapterParityHiggs
import Definitions.Def_ChapterParity
open BookProof.ChapterParity
open BookProof.ChapterParityHiggs


open Matrix
open scoped Kronecker
open scoped ComplexConjugate


open BookProof.ChapterParity

theorem BookProof.ChapterParityHiggs.higgsDoublet_pseudoreal (v : Fin 2 → ℂ) :
    realityOp pauli2 (realityOp pauli2 v) = -v := by sorry
