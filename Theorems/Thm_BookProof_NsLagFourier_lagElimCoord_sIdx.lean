-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimCoord_sIdx
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination



open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore

noncomputable section

variable {n : ℕ}


theorem BookProof.NsLagFourier.lagElimCoord_sIdx (l : Fin 3 → ℝ) (i : Fin 3) :
    lagElimCoord l (sIdx i)
      = -C (((∑ j : Fin 3, (l j) ^ 2 : ℝ)) : ℂ) * X (vIdx12 i) := by sorry
