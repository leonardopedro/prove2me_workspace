-- Generated from ChapterNsOuterFockFarisLavine.lean — solution of BookProof.NsOuterFock.nsOuterFock_esa_farisLavine
import Mathlib
import Definitions.Def_ChapterNsOuterFockFarisLavine
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_esa_farisLavine
import Theorems.Thm_BookProof_SqSumOuterFamily_SqFamily_secExt_rel
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
    EssentiallySelfAdjointOn
        (outerFriedDom (nsFamily hB hbv hnu hlam hmu hgg).dim)
        (dsFibOp (fun n : ℕ => harmFried ((nsFamily hB hbv hnu hlam hmu hgg).dim n))
          (nsFamily hB hbv hnu hlam hmu hgg).secExt
          (nsFamily hB hbv hnu hlam hmu hgg).flK
          (nsFamily hB hbv hnu hlam hmu hgg).secExt_rel) ∧
      ∀ x : outerCore (nsFamily hB hbv hnu hlam hmu hgg).dim,
        ∃ h : (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim)
            ∈ outerFriedDom (nsFamily hB hbv hnu hlam hmu hgg).dim,
          dsFibOp (fun n : ℕ => harmFried ((nsFamily hB hbv hnu hlam hmu hgg).dim n))
              (nsFamily hB hbv hnu hlam hmu hgg).secExt
              (nsFamily hB hbv hnu hlam hmu hgg).flK
              (nsFamily hB hbv hnu hlam hmu hgg).secExt_rel
              ⟨(x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim), h⟩
            = (nsFamily hB hbv hnu hlam hmu hgg).outerHam x := (nsFamily hB hbv hnu hlam hmu hgg).esa_farisLavine
