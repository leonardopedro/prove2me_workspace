-- Generated from ChapterNsOuterFockFarisLavine.lean — theorem BookProof.NsOuterFock.linForm_nsVec
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

theorem BookProof.NsOuterFock.linForm_nsVec {n : ℕ} (p : Fin n) (f : NsLoc) (hne : nextPart p ≠ p) :
    linForm (nsVec bv nu lam mu gg n (p, f))
      = (∑ l : NsLoc, ((sameVec bv nu lam mu gg f l : ℝ) : ℂ) • X (coordOf p l))
        + ∑ l : NsLoc, ((nextVec lam mu f l : ℝ) : ℂ) • X (coordOf (nextPart p) l) := by sorry
