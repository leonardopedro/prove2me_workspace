-- Generated from ChapterShiftedQuadraticMatrixEsa.lean — theorem BookProof.ShiftedQuadraticMatrix.shiftedHMatPoly_eq_quadPolyMat
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterShiftedHermiteCore
import Definitions.Def_ChapterShiftedQuadraticEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterShiftedQuadraticMatrixEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.ShiftedQuadraticMatrix

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.QuadraticRotation
open BookProof.ShiftedHermiteCore
open BookProof.ShiftedQuadratic
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.ShiftedQuadraticMatrix.shiftedHMatPoly_eq_quadPolyMat (a k : Vd d) {A : Matrix (Fin d) (Fin d) ℝ}
    (hsym : ∀ i j, A i j = A j i) (b b' : Fin d → ℝ)
    (ha : ∀ i, ∑ j, A i j * a j = -2 * b i)
    (hk : ∀ i, ∑ j, A i j * k j = -(b' i) / 2)
    (f : MvPolynomial (Fin d) ℂ) :
    shiftedHMatPoly a k A b b' f
      = quadPolyMat A f + ((matShiftConst a k b b' : ℝ) : ℂ) • f := by sorry
