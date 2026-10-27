-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.foOp_coe
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
import Theorems.Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b b' : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) :
    (foOp b b' (coreEquiv p)) = pgLp (foPoly b b' p) := coreOp_coe _ p
