-- Generated from ChapterQuadratureEsa.lean — solution of BookProof.QuadratureEsa.phasePow_add_single
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
theorem solution (zeta : Fin d → ℂ) (i : Fin d) (a : Fin d →₀ ℕ) :
    phasePow zeta (a + Finsupp.single i 1) = phasePow zeta a * zeta i := by

  classical
  have h : ∀ j : Fin d, zeta j ^ ((a + Finsupp.single i 1 : Fin d →₀ ℕ) j)
      = zeta j ^ (a j) * (if j = i then zeta i else 1) := by
    intro j
    have hj : ((a + Finsupp.single i 1 : Fin d →₀ ℕ) j) = a j + (if j = i then 1 else 0) := by
      simp [Finsupp.single_apply, eq_comm]
    rw [hj, pow_add]
    split_ifs with hji
    · rw [hji, pow_one]
    · rw [pow_zero]
  rw [phasePow, phasePow, Finset.prod_congr rfl fun j _ => h j, Finset.prod_mul_distrib,
    Finset.prod_ite_eq' Finset.univ i (fun _ => zeta i)]
  simp
