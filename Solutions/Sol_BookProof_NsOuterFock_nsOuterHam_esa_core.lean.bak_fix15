-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.nsOuterHam_esa_core
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_outerHam_esa
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
theorem solution :
    EssentiallySelfAdjointOn (outerCore (nsFamily hB hbv hnu hlam hmu hgg).dim)
      (nsFamily hB hbv hnu hlam hmu hgg).outerHam := (nsFamily hB hbv hnu hlam hmu hgg).outerHam_esa
