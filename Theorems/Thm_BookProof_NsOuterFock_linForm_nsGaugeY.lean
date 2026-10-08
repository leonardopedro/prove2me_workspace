-- Generated from ChapterNsOuterFockFarisLavine.lean — theorem BookProof.NsOuterFock.linForm_nsGaugeY
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterSqSumOuterFamily
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockEsa
open BookProof.QgOuterFock
open BookProof.NsOuterFock



open Finset MvPolynomial
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.SqSumOuterFamily

noncomputable section

variable (bv : Fin 3 → ℝ) (nu lam mu gg : ℝ)

theorem BookProof.NsOuterFock.linForm_nsGaugeY {n : ℕ} (p : Fin n) (j : Fin 3) (hne : nextPart p ≠ p) :
    linForm (nsVec bv nu lam mu gg n (p, locY j))
      = ((gg : ℝ) : ℂ) • X (coordOf p (locY j)) := by sorry
