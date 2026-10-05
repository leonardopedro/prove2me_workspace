-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimSubst_piola
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


theorem BookProof.NsLagFourier.lagElimSubst_piola (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    lagElimHom l n (∑ j : Fin 3, cofPoly p j i * X (ycoord p (qIdx j))) = 0 := by sorry
