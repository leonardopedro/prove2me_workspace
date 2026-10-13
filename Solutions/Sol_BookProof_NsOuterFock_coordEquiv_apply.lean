-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.coordEquiv_apply
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterQgOuterFockInteractionFL
import Definitions.Def_ChapterSqSumOuterFamily
open BookProof.NsOuterFock




open Finset MvPolynomial
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore BookProof.QgHermiteOscillator
open BookProof.QgOuterFock BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL
open BookProof.SqSumOuterFamily

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) (l : NsLoc) :
    coordEquiv n (p, l) = coordOf p l := rfl
