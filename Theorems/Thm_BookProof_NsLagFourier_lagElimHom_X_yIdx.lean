-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimHom_X_yIdx
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
open BookProof.NsLagFourier



open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}


theorem BookProof.NsLagFourier.lagElimHom_X_yIdx (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (j : Fin 3) :
    lagElimHom l n (X (ycoord p (yIdx j))) = 0 := by sorry
