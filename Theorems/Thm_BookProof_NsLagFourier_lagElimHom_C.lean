-- Generated from ChapterNsLagrangianFourierElimination.lean — theorem BookProof.NsLagFourier.lagElimHom_C
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


theorem BookProof.NsLagFourier.lagElimHom_C (l : Fin 3 → ℝ) (n : ℕ) (c : ℂ) :
    lagElimHom l n (C c : MvPolynomial (Fin (n * 36)) ℂ)
      = (C c : MvPolynomial (Fin (n * 12)) ℂ) := by sorry
