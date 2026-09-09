-- Generated from ChapterHermiteRelativeBound.lean — solution of BookProof.HermiteRelative.foOp_linear_apply_eq_mul
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
theorem solution (b : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFun (foPoly b 0 p) x = ((∑ i, b i * x i : ℝ) : ℂ) * pgFun p x := by

  classical
  have hpoly : foPoly b 0 p = ∑ i, ((b i : ℝ) : ℂ) • (X i * p) := by
    simp [foPoly, mulXPoly]
  rw [hpoly]
  have : pgFun (∑ i, ((b i : ℝ) : ℂ) • (X i * p)) x
      = ∑ i, ((b i : ℝ) : ℂ) * pgFun (X i * p) x := by
    classical
    induction (Finset.univ : Finset (Fin d)) using Finset.induction with
    | empty => simp [pgFun]
    | insert i s hi ih =>
        rw [Finset.sum_insert hi, Finset.sum_insert hi,
          BookProof.HyperbolicQuadratic.pgFun_add, ih,
          BookProof.HyperbolicQuadratic.pgFun_smul]
  rw [this]
  have hx : ∀ i : Fin d, pgFun ((X i : MvPolynomial (Fin d) ℂ) * p) x
      = ((x i : ℝ) : ℂ) * pgFun p x := fun i => by
    simpa using posOp_apply_eq_mul i p x
  simp_rw [hx]
  push_cast
  rw [Finset.sum_mul]
  exact Finset.sum_congr rfl fun i _ => by ring
