-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.phasePow_sub_single
import Mathlib
import Definitions.Def_ChapterQuadratureEsa
open BookProof.QuadratureEsa




open MeasureTheory MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.YangMillsHermite
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (zeta : Fin d → ℂ) {i : Fin d} {a : Fin d →₀ ℕ} (ha : 0 < a i) :
    phasePow zeta (a - Finsupp.single i 1) * zeta i = phasePow zeta a := by

  classical
  have h : ∀ j : Fin d, zeta j ^ ((a - Finsupp.single i 1 : Fin d →₀ ℕ) j)
      * (if j = i then zeta i else 1) = zeta j ^ (a j) := by
    intro j
    have hj : ((a - Finsupp.single i 1 : Fin d →₀ ℕ) j) = a j - (if j = i then 1 else 0) := by
      simp [Finsupp.tsub_apply, Finsupp.single_apply, eq_comm]
    rw [hj]
    split_ifs with hji
    · subst hji
      rw [← pow_succ]
      congr 1
      omega
    · rw [mul_one, Nat.sub_zero]
  rw [phasePow, phasePow, ← Finset.prod_congr rfl fun j _ => h j, Finset.prod_mul_distrib,
    Finset.prod_ite_eq' Finset.univ i (fun _ => zeta i)]
  simp
