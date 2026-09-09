-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.polySym_foPoly
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_polySym_mulXPoly
import Theorems.Thm_BookProof_HermiteRelative_polySym_momPoly
import Theorems.Thm_BookProof_HermiteRelative_polySym_sum
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
theorem solution (b b' : Fin d → ℝ) : BookProof.YangMillsHermite.PolySym (foPoly b b') :=
  polySym_sum _ _ fun i _ =>
      (BookProof.YangMillsHermite.PolySym.real_smul (polySym_mulXPoly i)).add
        (BookProof.YangMillsHermite.PolySym.real_smul (polySym_momPoly i))
