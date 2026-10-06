-- Generated from ChapterGaussCoordCombo.lean — solution of BookProof.GaussCoordCombo.pderiv_hermiteFactor_of_ne
import Mathlib
import Definitions.Def_ChapterGaussCoordCombo
import Theorems.Thm_BookProof_GaussCoordCombo_pderiv_aeval_of_ne
open BookProof.GaussCoordCombo




open MvPolynomial BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin d} (h : j ≠ i) (n : ℕ) :
    pderiv j (hermiteFactor i n) = 0 := pderiv_aeval_of_ne h _
