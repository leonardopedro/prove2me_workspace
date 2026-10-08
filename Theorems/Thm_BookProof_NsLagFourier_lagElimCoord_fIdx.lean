-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimCoord_fIdx
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


theorem BookProof.NsLagFourier.lagElimCoord_fIdx (l : Fin 3 → ℝ) (i j : Fin 3) :
    lagElimCoord l (fIdx i j) = C (Complex.I * (((l j : ℝ)) : ℂ)) * X (xiIdx12 i) := by sorry
