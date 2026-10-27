-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.pgLp_add'
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
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
theorem solution (p q : MvPolynomial (Fin d) ℂ) : pgLp (p + q) = pgLp p + pgLp q := map_add (pgMap (d := d)) p q
