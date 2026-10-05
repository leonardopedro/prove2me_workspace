-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimHom_X_vgIdx
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


theorem BookProof.NsLagFourier.lagElimHom_X_vgIdx (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i j : Fin 3) :
    lagElimHom l n (X (ycoord p (vgIdx i j)))
      = C (Complex.I * (((l j : ℝ)) : ℂ)) * X (lRedIdx p (vIdx12 i)) := by sorry
