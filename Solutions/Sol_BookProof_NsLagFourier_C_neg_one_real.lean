-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.C_neg_one_real
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    (C (((-1 : ℝ) : ℂ)) : MvPolynomial (Fin (n * 12)) ℂ) = -1 := by

  rw [show (((-1 : ℝ) : ℂ)) = -(1 : ℂ) by norm_num, C_neg, C_1]
