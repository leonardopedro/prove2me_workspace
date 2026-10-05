-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.nsFamily_dim
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
theorem solution : (nsFamily hB hbv hnu hlam hmu hgg).dim = fun n => n * 18 := rfl
