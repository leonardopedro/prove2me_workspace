-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.symmetricOn_of_polySym
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
theorem BookProof.HermiteRelative.symmetricOn_of_polySym {T : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ}
    (hT : BookProof.YangMillsHermite.PolySym T) :
    SymmetricOn (polyGaussCore (d := d))
      ((polyGaussCore (d := d)).subtype ∘ₗ coreOp T) := by sorry
