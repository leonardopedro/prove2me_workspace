-- Generated from ChapterNsOuterFockFarisLavine.lean — theorem BookProof.NsOuterFock.linForm_nsConstraint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterA4
open BookProof.QgOuterFock
open BookProof.NsOuterFock

variable (bv : Fin 3 → ℝ) (nu lam mu gg : ℝ)



open Finset MvPolynomial
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.SqSumOuterFamily

noncomputable section

theorem BookProof.NsOuterFock.linForm_nsConstraint {n : ℕ} (p : Fin n) (i : Fin 3) (hne : nextPart p ≠ p) :
    linForm (nsVec bv nu lam mu gg n (p, locU i))
      = (∑ j : Fin 3, ((bv j : ℝ) : ℂ) • X (coordOf p (locD i j)))
        - ((nu : ℝ) : ℂ) • X (coordOf p (locL i)) := by sorry
