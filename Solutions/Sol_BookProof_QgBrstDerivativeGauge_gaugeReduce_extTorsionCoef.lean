-- Generated from ChapterQgBrstDerivativeGauge.lean — solution of BookProof.QgBrstDerivativeGauge.gaugeReduce_extTorsionCoef
import Mathlib
import Definitions.Def_ChapterQgBrstDerivativeGauge




open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section
private theorem delta_triple (rho mu nu i p1 p2 : Fin 3) :
    (if ((rho, p1, p2) : Fin 3 × Fin 3 × Fin 3) = (mu, nu, i) then (1 : ℂ) else 0)
      = (if rho = mu then (1 : ℂ) else 0) * (if (p1, p2) = (nu, i) then 1 else 0) := by
  by_cases h1 : rho = mu <;> by_cases h2 : (p1, p2) = (nu, i) <;>
    simp [h1, h2, Prod.ext_iff]
private theorem sum_delta (k : Mom) (mu nu i p1 p2 : Fin 3) :
    ∑ rho : Fin 3, ((k rho : ℤ) : ℂ) *
        (if ((rho, p1, p2) : Fin 3 × Fin 3 × Fin 3) = (mu, nu, i) then (1 : ℂ) else 0)
      = if (p1, p2) = (nu, i) then ((k mu : ℤ) : ℂ) else 0 := by
  have hsum : ∑ rho : Fin 3, ((k rho : ℤ) : ℂ) *
      (if ((rho, p1, p2) : Fin 3 × Fin 3 × Fin 3) = (mu, nu, i) then (1 : ℂ) else 0)
      = (if (p1, p2) = (nu, i) then (1 : ℂ) else 0) *
          ∑ rho : Fin 3, (if rho = mu then ((k rho : ℤ) : ℂ) else 0) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun rho _ => ?_
    rw [delta_triple rho mu nu i p1 p2]
    by_cases h1 : rho = mu <;> by_cases h2 : (p1, p2) = (nu, i) <;> simp [h1, h2]
  rw [hsum, Finset.sum_ite_eq' Finset.univ mu (fun rho => ((k rho : ℤ) : ℂ))]
  by_cases h2 : (p1, p2) = (nu, i) <;> simp [h2]

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (mu nu i : Fin 3) (x : CMode) :
    gaugeReduce (extTorsionCoef k mu nu i) x
      = if x.1 = k then torsionCoef k mu nu i x else 0 := by

  by_cases hk : x.1 = k
  · subst hk
    simp only [gaugeReduce, extTorsionCoef, if_true, zero_add, mul_sub,
      Finset.sum_sub_distrib]
    rw [sum_delta x.1 mu nu i x.2.1 x.2.2, sum_delta x.1 nu mu i x.2.1 x.2.2]
    simp only [torsionCoef]
  · simp only [gaugeReduce, extTorsionCoef, if_neg hk, mul_zero, Finset.sum_const_zero,
      add_zero]
