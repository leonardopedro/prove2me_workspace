-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.nsFamily_vv
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
variable {bv nu lam mu gg}
variable {B : ℝ} (hB : 0 ≤ B) (hbv : ∀ j, |bv j| ≤ B) (hnu : |nu| ≤ B) (hlam : |lam| ≤ B)
  (hmu : |mu| ≤ B) (hgg : |gg| ≤ B)

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (r : Fin n × NsLoc)
    (I : Fin ((nsFamily hB hbv hnu hlam hmu hgg).dim n)) :
    (nsFamily hB hbv hnu hlam hmu hgg).vv n r I = nsVec bv nu lam mu gg n r I := rfl
