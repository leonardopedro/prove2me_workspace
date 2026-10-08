-- Generated from ChapterParity.lean — theorem BookProof.ChapterParity.gellMann_parity_sign
import Mathlib
import Definitions.Def_ChapterParity
open BookProof.ChapterParity


open Matrix
open scoped ComplexConjugate

variable {n : Type*}

theorem BookProof.ChapterParity.gellMann_parity_sign (a : Fin 8) :
    -((gellMann a).map (starRingEnd ℂ)) = (-(gellMannConjSign a)) • gellMann a := by sorry
