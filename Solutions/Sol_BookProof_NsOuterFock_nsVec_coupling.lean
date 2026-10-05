-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.nsVec_coupling
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

variable (bv : Fin 3 → ℝ) (nu lam mu gg : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) (i j : Fin 3) (hne : nextPart p ≠ p) :
    nsVec bv nu lam mu gg n (p, locD i j) (coordOf (nextPart p) (locU i)) = -lam := by

  simp [nsVec, locD, locU, nextVec, hne]
