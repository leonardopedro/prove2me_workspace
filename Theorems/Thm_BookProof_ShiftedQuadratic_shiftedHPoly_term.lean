-- Generated from ChapterShiftedQuadraticEsa.lean — theorem BookProof.ShiftedQuadratic.shiftedHPoly_term
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticEsa
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterShiftedHermiteCore
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic

variable {d : ℕ}



open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.ShiftedQuadratic.shiftedHPoly_term (c b b' : Fin d → ℝ) (i : Fin d) (hc : c i ≠ 0)
    (p : MvPolynomial (Fin d) ℂ) :
    ((c i : ℝ) : ℂ) • oscTPoly (shiftVec c b) (boostVec c b') i p
        + ((b i : ℝ) : ℂ) • mulXTPoly (shiftVec c b) i p
        + ((b' i : ℝ) : ℂ) • momTPoly (boostVec c b') i p
      = ((c i : ℝ) : ℂ) • oscPoly i p
        + (((-(b' i ^ 2) / (4 * c i) - b i ^ 2 / c i : ℝ)) : ℂ) • p := by sorry
