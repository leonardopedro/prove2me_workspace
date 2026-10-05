-- Generated from ChapterQuadraticRotationEsa.lean — theorem BookProof.QuadraticRotation.quadOpMat_rotHermiteLp
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQuadraticRotationEsa
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.QuadraticRotation

variable {d : ℕ}



open MeasureTheory MvPolynomial Matrix
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section


theorem BookProof.QuadraticRotation.quadOpMat_rotHermiteLp {O : Matrix (Fin d) (Fin d) ℝ} (hO : Oᵀ * O = 1)
    (c : Fin d → ℝ) (a : Fin d →₀ ℕ) (h : rotHermiteLp O a ∈ polyGaussCore (d := d)) :
    quadOpMat (rotConj O c) ⟨rotHermiteLp O a, h⟩
      = ((quadSymbol c a : ℝ) : ℂ) • rotHermiteLp O a := by sorry
