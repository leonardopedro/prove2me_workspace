-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.coordEquiv_apply
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
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
