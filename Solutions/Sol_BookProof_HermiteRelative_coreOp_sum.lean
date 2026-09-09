-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.coreOp_sum
import Mathlib
import Definitions.Def_ChapterHermiteRelativeBound
import Theorems.Thm_BookProof_HermiteRelative_coreOp_add
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
theorem solution {ι : Type*} (s : Finset ι)
    (T : ι → MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ) :
    coreOp (∑ i ∈ s, T i) = ∑ i ∈ s, coreOp (T i) := by

  classical
  induction s using Finset.induction with
  | empty => refine LinearMap.ext fun x => ?_; simp [coreOp_apply']
  | insert i s hi ih => rw [Finset.sum_insert hi, coreOp_add, ih, Finset.sum_insert hi]
