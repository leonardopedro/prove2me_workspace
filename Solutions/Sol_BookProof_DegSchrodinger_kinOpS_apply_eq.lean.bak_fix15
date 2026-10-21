-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.kinOpS_apply_eq
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset (Fin d)) (f : 𝓢(Vd d, ℂ)) (x : Vd d) :
    (kinOpS S f) x = -lapCS S (f : Vd d → ℂ) x := by

  have h : (kinOpS S f)
      = (∑ i : Fin d, ((kinCoeff S i : ℝ) : ℂ) • secondDeriv (kinDir d i) f)
        + ((0 : ℝ) : ℂ) • f := by
    simp [kinOpS, constCoeffOp]
  rw [h]
  simp only [SchwartzMap.add_apply, SchwartzMap.sum_apply, SchwartzMap.smul_apply, smul_eq_mul,
    Complex.ofReal_zero, zero_mul, add_zero, secondDeriv_apply_eq, lapCS, dcoord]
  rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (fun i => i ∈ S)]
  have h2 : ∀ i ∈ Finset.univ.filter (fun i : Fin d => ¬ i ∈ S),
      ((kinCoeff S i : ℝ) : ℂ) *
        fderiv ℝ (fun y => fderiv ℝ (f : Vd d → ℂ) y (kinDir d i)) x (kinDir d i) = 0 := by
    intro i hi
    simp only [Finset.mem_filter] at hi
    simp [kinCoeff, hi.2]
  rw [Finset.sum_eq_zero h2, add_zero]
  have h3 : (Finset.univ.filter (fun i : Fin d => i ∈ S)) = S := by
    ext i; simp
  rw [h3, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i hi => ?_
  simp only [kinCoeff, hi, if_pos, Complex.ofReal_neg, Complex.ofReal_one, neg_one_mul]
  rfl
