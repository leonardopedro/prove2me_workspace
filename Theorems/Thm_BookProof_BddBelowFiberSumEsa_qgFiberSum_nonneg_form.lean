-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.qgFiberSum_nonneg_form
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
import Definitions.Def_ChapterWallEsaSemibounded
import Theorems.Thm_BookProof_BddBelowFiberSumEsa_contDiff_qgFiberV
open BookProof.WallEsaSemibounded
open BookProof.BddBelowFiberSumEsa

variable {ι : Type*}

theorem BookProof.BddBelowFiberSumEsa.qgFiberSum_nonneg_form {M alpha : ℝ} (halpha : 0 < alpha) {d : ℕ} (omega : Fin d → ℝ) :
    SemiboundedBelowOn (fiberCore (Option (Fin d)))
      (fiberSumHam (qgFiberV M alpha omega) (contDiff_qgFiberV M alpha omega)) 0 := by sorry
