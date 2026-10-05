-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.rankOne_cof_zero
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


theorem BookProof.NsLagFourier.rankOne_cof_zero (b ζ : Fin 3 → MvPolynomial (Fin (n * 12)) ℂ) (i j : Fin 3) :
    (b (cyc j 1) * ζ (cyc i 1)) * (b (cyc j 2) * ζ (cyc i 2))
      + (-1) * ((b (cyc j 2) * ζ (cyc i 1)) * (b (cyc j 1) * ζ (cyc i 2))) = 0 := by sorry
