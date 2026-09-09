-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.posL_symmetric
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_polySym_mulXPoly
import Theorems.Thm_BookProof_HermiteRelative_symmetricOn_of_polySym
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
set_option maxHeartbeats 1000000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
theorem solution (i : Fin d) : SymmetricOn (polyGaussCore (d := d)) (posL i) := symmetricOn_of_polySym (polySym_mulXPoly i)
