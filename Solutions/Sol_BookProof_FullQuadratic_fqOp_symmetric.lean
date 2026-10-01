-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.fqOp_symmetric
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_polySym_fqPoly
import Theorems.Thm_BookProof_HermiteRelative_symmetricOn_of_polySym
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

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 1600000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem solution (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (fqOp P Q S b b') := symmetricOn_of_polySym (polySym_fqPoly P Q S b b')
