-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimCoord_vgIdx
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Definitions.Def_ChapterA4
open BookProof.NsLagFourier

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section


theorem BookProof.NsLagFourier.lagElimCoord_vgIdx (l : Fin 3 → ℝ) (i j : Fin 3) :
    lagElimCoord l (vgIdx i j) = C (Complex.I * (((l j : ℝ)) : ℂ)) * X (vIdx12 i) := by sorry
