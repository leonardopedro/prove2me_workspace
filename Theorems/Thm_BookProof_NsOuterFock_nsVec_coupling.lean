-- Generated from ChapterNsOuterFockFarisLavine.lean — theorem BookProof.NsOuterFock.nsVec_coupling
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterSqSumOuterFamily
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
open BookProof.NsOuterFock

variable (bv : Fin 3 → ℝ) (nu lam mu gg : ℝ)



open Finset MvPolynomial
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.SqSumOuterFamily

noncomputable section

theorem BookProof.NsOuterFock.nsVec_coupling {n : ℕ} (p : Fin n) (i j : Fin 3) (hne : nextPart p ≠ p) :
    nsVec bv nu lam mu gg n (p, locD i j) (coordOf (nextPart p) (locU i)) = -lam := by sorry
