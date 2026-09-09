-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.hermiteMvBasis_repr_quadOp
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

theorem BookProof.HermiteRelative.hermiteMvBasis_repr_quadOp (c : Fin d → ℝ) (u : polyGaussCore (d := d))
    (a : Fin d →₀ ℕ) :
    hermiteMvBasis.repr (quadOp c u) a
      = ((quadSymbol c a : ℝ) : ℂ) * hermiteMvBasis.repr (u : L2d d) a := by sorry
