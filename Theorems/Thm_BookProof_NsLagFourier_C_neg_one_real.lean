-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.C_neg_one_real
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
open BookProof.NsLagFourier

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section


theorem BookProof.NsLagFourier.C_neg_one_real (n : ℕ) :
    (C (((-1 : ℝ) : ℂ)) : MvPolynomial (Fin (n * 12)) ℂ) = -1 := by sorry
