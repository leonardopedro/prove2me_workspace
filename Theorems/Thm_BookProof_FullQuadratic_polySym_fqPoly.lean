-- Generated from ChapterFullQuadraticEsa.lean — theorem BookProof.FullQuadratic.polySym_fqPoly
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
open BookProof.FullQuadratic
















open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

theorem BookProof.FullQuadratic.polySym_fqPoly (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (fqPoly P Q S b b') := by sorry
