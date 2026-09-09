-- Generated from ChapterHermiteRelativeBound.lean — theorem BookProof.HermiteRelative.polySym_sum
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

theorem BookProof.HermiteRelative.polySym_sum {ι : Type*} (s : Finset ι)
    (T : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ)
    (h : ∀ i ∈ s, BookProof.YangMillsHermite.PolySym (T i)) :
    BookProof.YangMillsHermite.PolySym (∑ i ∈ s, T i) := by sorry
