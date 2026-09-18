-- Generated from ChapterH8.lean — theorem BookProof.ChapterH8.adjoint_aeval
import Mathlib
import Definitions.Def_ChapterH8
open BookProof.ChapterH8


noncomputable section


open BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6

theorem BookProof.ChapterH8.adjoint_aeval (A : F →L[ℂ] F) (p : Polynomial ℂ) :
    adjoint (Polynomial.aeval A p) = Polynomial.aeval (adjoint A) (p.map (starRingEnd ℂ)) := by sorry
