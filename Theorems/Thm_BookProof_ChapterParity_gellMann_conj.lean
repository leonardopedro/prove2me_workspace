-- Generated from ChapterParity.lean — theorem BookProof.ChapterParity.gellMann_conj
import Mathlib
import Definitions.Def_ChapterParity
open BookProof.ChapterParity


open Matrix
open scoped ComplexConjugate

variable {n : Type*}

theorem BookProof.ChapterParity.gellMann_conj (a : Fin 8) :
    (gellMann a).map (starRingEnd ℂ) = (gellMannConjSign a) • gellMann a := by sorry
