-- Generated from ChapterGellMann.lean — theorem BookProof.ChapterGellMann.gellMann_trace_orthonormal
import Mathlib
import Definitions.Def_ChapterGellMann
import Definitions.Def_ChapterParity
open BookProof.ChapterParity
open BookProof.ChapterGellMann


open Matrix


open BookProof.ChapterParity

theorem BookProof.ChapterGellMann.gellMann_trace_orthonormal (a b : Fin 8) :
    (gellMann a * gellMann b).trace = (if a = b then (2 : ℂ) else 0) := by sorry
