-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimSubst_lagResPoly
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


theorem BookProof.NsLagFourier.lagElimSubst_lagResPoly (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    lagElimHom l n (lagResPoly p i)
      = X (lRedIdx p (accIdx12 i))
        + C (((∑ j : Fin 3, (l j) ^ 2 : ℝ)) : ℂ) * X (lRedIdx p (vIdx12 i)) := by sorry
