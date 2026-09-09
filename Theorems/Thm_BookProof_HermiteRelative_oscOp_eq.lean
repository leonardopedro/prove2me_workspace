-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.oscOp_eq
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
open BookProof.HermiteRelative









open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic

noncomputable section



variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] {ι : Type*}





variable {d : ℕ}

set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem BookProof.HermiteRelative.oscOp_eq (i : Fin d) :
    coreOp (oscPoly i) = (coreOp (momPoly i)).comp (coreOp (momPoly i))
      + (1/4 : ℂ) • ((coreOp (mulXPoly i)).comp (coreOp (mulXPoly i))) := by sorry
