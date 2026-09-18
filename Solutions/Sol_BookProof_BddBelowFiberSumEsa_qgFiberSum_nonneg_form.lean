-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.qgFiberSum_nonneg_form
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Theorems.Thm_BookProof_BddBelowFiberSumEsa_fiberSumHam_nonneg_form
import Theorems.Thm_BookProof_BddBelowFiberSumEsa_contDiff_qgFiberV
import Theorems.Thm_BookProof_BddBelowFiberSumEsa_qgFiberV_nonneg
open BookProof.BddBelowFiberSumEsa












open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (halpha : 0 < alpha) {d : ℕ} (omega : Fin d → ℝ) :
    SemiboundedBelowOn (fiberCore (Option (Fin d)))
      (fiberSumHam (qgFiberV M alpha omega) (contDiff_qgFiberV M alpha omega)) 0 := fiberSumHam_nonneg_form _ _ (qgFiberV_nonneg halpha omega)
