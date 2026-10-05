-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimHom_X_xiIdx
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


theorem BookProof.NsLagFourier.lagElimHom_X_xiIdx (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    lagElimHom l n (X (ycoord p (xiIdx i))) = X (lRedIdx p (xiIdx12 i)) := by sorry
